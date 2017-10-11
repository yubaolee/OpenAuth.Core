using System;

namespace OpenAuth.Domain
{
    public abstract class Entity
    {
        public string Id { get; set; }

        public Entity()
        {
            Id = Guid.NewGuid().ToString();
        }
    }
}
