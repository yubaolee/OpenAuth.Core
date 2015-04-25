using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OpenAuth.Infrastructure.Repository
{
    public class BaseRepository
    {
        protected OpenAuthDBContext _Context = new OpenAuthDBContext();
    }
}
