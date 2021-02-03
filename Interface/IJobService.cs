using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CrudOperations.Models;

namespace CrudOperations.Interface
{
    public interface IJobService
    {
        int Delete(int JobId);
        JobEntity GetByJobId(int JobId);
        string Update(JobEntity job);
        int Create(JobEntity JobDetails);
        List<JobEntity> ListAll();
    }
}
