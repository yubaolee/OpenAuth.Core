using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Xml.Serialization;

namespace SchemaMapper
{
    #region Base
    public enum Cardinality
    {
        ZeroOrOne,
        One,
        Many
    }

    public class EntityBase
    {
        [XmlIgnore]
        public bool IsProcessed { get; set; }
    }
    #endregion

    #region Model
    [DebuggerDisplay("Context: {ContextName}, Database: {DatabaseName}")]
    public class EntityContext : EntityBase
    {
        public EntityContext()
        {
            Entities = new EntityCollection();
        }

        public string ClassName { get; set; }
        public string DatabaseName { get; set; }

        public EntityCollection Entities { get; set; }

        public void RenameEntity(string originalName, string newName)
        {
            if (originalName == newName)
                return;

            Debug.WriteLine("Rename Entity '{0}' to '{1}'.", originalName, newName);
            foreach (var entity in Entities)
            {
                if (entity.ClassName == originalName)
                    entity.ClassName = newName;

                foreach (var relationship in entity.Relationships)
                {
                    if (relationship.ThisEntity == originalName)
                        relationship.ThisEntity = newName;
                    if (relationship.OtherEntity == originalName)
                        relationship.OtherEntity = newName;
                }
            }
        }

        public void RenameProperty(string entityName, string originalName, string newName)
        {
            if (originalName == newName)
                return;

            Debug.WriteLine("Rename Property '{0}' to '{1}' in Entity '{2}'.", originalName, newName, entityName);
            foreach (var entity in Entities)
            {
                if (entity.ClassName == entityName)
                {
                    var property = entity.Properties.ByProperty(originalName);
                    if (property != null)
                        property.PropertyName = newName;
                }

                foreach (var relationship in entity.Relationships)
                {
                    if (relationship.ThisEntity == entityName)
                        for (int i = 0; i < relationship.ThisProperties.Count; i++)
                            if (relationship.ThisProperties[i] == originalName)
                                relationship.ThisProperties[i] = newName;

                    if (relationship.OtherEntity == entityName)
                        for (int i = 0; i < relationship.OtherProperties.Count; i++)
                            if (relationship.OtherProperties[i] == originalName)
                                relationship.OtherProperties[i] = newName;
                }
            }

        }
    }

    [DebuggerDisplay("Class: {ClassName}, Table: {FullName}, Context: {ContextName}")]
    public class Entity : EntityBase
    {
        public Entity()
        {
            Properties = new PropertyCollection();
            Relationships = new RelationshipCollection();
            Methods = new MethodCollection();
        }

        public string ContextName { get; set; }
        public string ClassName { get; set; }
        public string MappingName { get; set; }
        public string Description{ get;set;}

        public string TableSchema { get; set; }
        public string TableName { get; set; }
        public string FullName { get; set; }

        public PropertyCollection Properties { get; set; }
        public RelationshipCollection Relationships { get; set; }
        public MethodCollection Methods { get; set; }
    }

    [DebuggerDisplay("Property: {PropertyName}, Column: {ColumnName}, Type: {NativeType}")]
    public class Property : EntityBase
    {
        public string PropertyName { get; set; }
        public string ColumnName { get; set; }
        public string Description { get; set; }

        public DbType DataType { get; set; }
        public string NativeType { get; set; }

        [XmlIgnore]
        public Type SystemType { get; set; }

        public int? Order { get; set; }
        public bool OrderSpecified
        {
            get { return Order.HasValue; }
        }

        public bool? IsNullable { get; set; }
        public bool IsNullableSpecified
        {
            get { return IsNullable.HasValue; }
        }

        public bool IsRequired
        {
            get { return IsNullable == false; }
            set { IsNullable = !value; }
        }
        public bool IsOptional
        {
            get { return IsNullable == true; }
            set { IsNullable = value; }
        }

        public bool? IsPrimaryKey { get; set; }
        public bool IsPrimaryKeySpecified
        {
            get { return IsPrimaryKey.HasValue; }
        }
        public bool? IsForeignKey { get; set; }
        public bool IsForeignKeySpecified
        {
            get { return IsForeignKey.HasValue; }
        }

        public bool? IsAutoGenerated { get; set; }
        public bool IsAutoGeneratedSpecified
        {
            get { return IsAutoGenerated.HasValue; }
        }
        public bool? IsReadOnly { get; set; }
        public bool IsReadOnlySpecified
        {
            get { return IsReadOnly.HasValue; }
        }
        public bool? IsRowVersion { get; set; }
        public bool IsRowVersionSpecified
        {
            get { return IsRowVersion.HasValue; }
        }
        public bool? IsIdentity { get; set; }
        public bool IsIdentitySpecified
        {
            get { return IsIdentity.HasValue; }
        }
        public bool? IsUnique { get; set; }
        public bool IsUniqueSpecified
        {
            get { return IsUnique.HasValue; }
        }

        public bool? IsUnicode { get; set; }
        public bool IsUnicodeSpecified
        {
            get { return IsUnicode.HasValue; }
        }
        public bool? IsFixedLength { get; set; }
        public bool IsFixedLengthSpecified
        {
            get { return IsFixedLength.HasValue; }
        }

        public int? MaxLength { get; set; }
        public bool MaxLengthSpecified
        {
            get { return MaxLength.HasValue; }
        }

        public byte? Precision { get; set; }
        public bool PrecisionSpecified
        {
            get { return Precision.HasValue; }
        }
        public int? Scale { get; set; }
        public bool ScaleSpecified
        {
            get { return Scale.HasValue; }
        }
    }

    [DebuggerDisplay("Other: {OtherEntity}, Property: {OtherPropertyName}, Relationship: {RelationshipName}")]
    public class Relationship : EntityBase
    {
        public Relationship()
        {
            OtherProperties = new List<string>();
            ThisProperties = new List<string>();
        }

        public string RelationshipName { get; set; }

        public string ThisEntity { get; set; }
        public string ThisPropertyName { get; set; }
        public Cardinality ThisCardinality { get; set; }
        public List<string> ThisProperties { get; set; }

        public string OtherEntity { get; set; }
        public string OtherPropertyName { get; set; }
        public Cardinality OtherCardinality { get; set; }
        public List<string> OtherProperties { get; set; }

        public bool? CascadeDelete { get; set; }
        public bool IsForeignKey { get; set; }
        public bool IsMapped { get; set; }

        public bool IsManyToMany
        {
            get
            {
                return ThisCardinality == Cardinality.Many
                  && OtherCardinality == Cardinality.Many;
            }
        }

        public bool IsOneToOne
        {
            get
            {
                return ThisCardinality != Cardinality.Many
                  && OtherCardinality != Cardinality.Many;
            }
        }

        public string JoinTable { get; set; }
        public string JoinSchema { get; set; }
        public List<string> JoinThisColumn { get; set; }
        public List<string> JoinOtherColumn { get; set; }

    }

    [DebuggerDisplay("Suffix: {NameSuffix}, IsKey: {IsKey}, IsUnique: {IsUnique}")]
    public class Method : EntityBase
    {
        public Method()
        {
            Properties = new List<Property>();
        }

        public string NameSuffix { get; set; }
        public string SourceName { get; set; }

        public bool IsKey { get; set; }
        public bool IsUnique { get; set; }
        public bool IsIndex { get; set; }

        public List<Property> Properties { get; set; }
    }
    #endregion

    #region Collections
    public class EntityCollection
      : ObservableCollection<Entity>
    {
        public bool IsProcessed { get; set; }

        public Entity ByTable(string fullName)
        {
            return this.FirstOrDefault(x => x.FullName == fullName);
        }

        public Entity ByTable(string tableName, string tableSchema)
        {
            return this.FirstOrDefault(x => x.TableName == tableName && x.TableSchema == tableSchema);
        }

        public Entity ByClass(string className)
        {
            return this.FirstOrDefault(x => x.ClassName == className);
        }

        public Entity ByContext(string contextName)
        {
            return this.FirstOrDefault(x => x.ContextName == contextName);
        }
    }

    public class PropertyCollection
      : ObservableCollection<Property>
    {
        public bool IsProcessed { get; set; }

        public IEnumerable<Property> PrimaryKeys
        {
            get { return this.Where(p => p.IsPrimaryKey == true); }
        }

        public IEnumerable<Property> ForeignKeys
        {
            get { return this.Where(p => p.IsForeignKey == true); }
        }

        public Property ByColumn(string columnName)
        {
            return this.FirstOrDefault(x => x.ColumnName == columnName);
        }

        public Property ByProperty(string propertyName)
        {
            return this.FirstOrDefault(x => x.PropertyName == propertyName);
        }
    }

    public class RelationshipCollection
      : ObservableCollection<Relationship>
    {
        public bool IsProcessed { get; set; }

        public Relationship ByName(string name)
        {
            return this.FirstOrDefault(x => x.RelationshipName == name);
        }

        public Relationship ByProperty(string propertyName)
        {
            return this.FirstOrDefault(x => x.ThisPropertyName == propertyName);
        }

        public Relationship ByOther(string name)
        {
            return this.FirstOrDefault(x => x.OtherEntity == name);
        }
    }

    public class MethodCollection 
        : ObservableCollection<Method>
    {
        public bool IsProcessed { get; set; }
    }

    #endregion
}

