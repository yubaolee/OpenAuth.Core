using OpenAuth.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OpenAuth.Repository
{
   public  class BaseRepository
    {
       protected OpenAuthDBContext Context = new OpenAuthDBContext();
    }
}
