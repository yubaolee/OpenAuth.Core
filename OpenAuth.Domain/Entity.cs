using System;

namespace OpenAuth.Domain
{
    public abstract class Entity
    {
        public System.Guid Id { get; set; }

        public Entity()
        {
            Id = Guid.NewGuid();
        }
    }
}
