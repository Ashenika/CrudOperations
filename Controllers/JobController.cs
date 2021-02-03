using CrudOperations.Interface;
using CrudOperations.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using CrudOperations.Models;

namespace CrudOperations.Controllers
{
    public class JobController : Controller
    {

        private readonly IJobService _jobManager;
        private readonly IHostingEnvironment _hostingEnvironment;

        public JobController(IJobService jobManager, IHostingEnvironment hostingEnvironment)
        {
            _jobManager = jobManager;
            _hostingEnvironment = hostingEnvironment;
        }

        //controller is defined in the startup.. the method name is the action/route

        //INDEX route 
        public IActionResult Index()
        {
            var data = _jobManager.ListAll();

            string baseUrl = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            foreach (var item in data)
            {
                if (!string.IsNullOrEmpty(item.JobImage))
                    item.JobImage = Path.Combine(baseUrl, "Images", item.JobImage);
                else
                    item.JobImage = Path.Combine(baseUrl, "Images", "404.png");
            }
            return View(data);
        }

        #region Add Job  
        //Add
        public ActionResult Add()
        {
            return View("addjob_view", new JobModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add(JobModel model)
        {
            if (ModelState.IsValid)
            {
                var fileName = "";
                if (Request.Form.Files.Count > 0)
                {
                    var file = Request.Form.Files[0];
                    var webRootPath = _hostingEnvironment.WebRootPath;
                    var newPath = Path.Combine(webRootPath, "images");
                    if (!Directory.Exists(newPath)) Directory.CreateDirectory(newPath);

                    if (file.Length > 0)
                    {
                        fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                        var fullPath = Path.Combine(newPath, fileName);
                        using (var stream = new FileStream(fullPath, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }
                    }
                }

                var job = new JobEntity()
                {
                    CityId = model.CityId,
                    JobImage = fileName,
                    CreatedBY = "1",
                    CreatedDateTime = DateTime.Now,
                    JobTitle = model.JobTitle,
                    UpdatedBY = "1",
                    IsActive = model.IsActive,
                    UpdatedDateTime = DateTime.Now
                };

                _jobManager.Create(job);
                return RedirectToAction("Index", "Job");
            }
            return View("addjob_view", model);
        }

        #endregion

        #region Edit Job  
        //Edit
        public ActionResult Edit(int JobId)
        {
            var jobEntity = _jobManager.GetByJobId(JobId);
            var jobModel = new JobModel
            {
                JobID = jobEntity.JobID,
                CityId = jobEntity.CityId,
                JobImage = jobEntity.JobImage,
                CreatedBY = jobEntity.CreatedBY,
                CreatedDateTime = jobEntity.CreatedDateTime,
                JobTitle = jobEntity.JobTitle,
                UpdatedBY = jobEntity.UpdatedBY,
                IsActive = jobEntity.IsActive,
                UpdatedDateTime = jobEntity.UpdatedDateTime
            };
            return View("addjob_view", jobModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(JobModel model)
        {
            if (ModelState.IsValid)
            {
                var fileName = model.JobImage ?? "";
                if (Request.Form.Files.Count > 0)
                {
                    var file = Request.Form.Files[0];
                    var webRootPath = _hostingEnvironment.WebRootPath;
                    var newPath = Path.Combine(webRootPath, "images");
                    if (!Directory.Exists(newPath)) Directory.CreateDirectory(newPath);

                    if (file.Length > 0)
                    {
                        fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                        var fullPath = Path.Combine(newPath, fileName);
                        using (var stream = new FileStream(fullPath, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }
                    }
                }

                var job = new JobEntity()
                {
                    JobID = model.JobID,
                    CityId = model.CityId,
                    JobImage = fileName,
                    JobTitle = model.JobTitle,
                    UpdatedBY = "1",
                    IsActive = model.IsActive,
                };

                _jobManager.Update(job);
                return RedirectToAction("Index", "Job");
            }
            return View("addjob_view", model);
        }

        #endregion

        #region Delete Job  
        //Delete
        public ActionResult Delete(int JobId)
        {
            var jobEntity = _jobManager.Delete(JobId);
            return RedirectToAction("Index", "Job");
        }

        #endregion
    }
}
