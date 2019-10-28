using System;
using System.ComponentModel;

namespace OpenAuth.Repository.Core
{
    public abstract class Entity
    {
        [Browsable(false)]
        public string Id { get; set; }

        public Entity()
        {
            Id = Guid.NewGuid().ToString();
        }
    }
}
