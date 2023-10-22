using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using System.ComponentModel;
using System.Reflection.Emit;

namespace RedHouse_Server.Models
{
    public class RedHouseDbContext : IdentityDbContext
    {
        public const DateTimeKind DefaultDateTimeKind = DateTimeKind.Utc;
        public RedHouseDbContext(DbContextOptions<RedHouseDbContext> options) : base(options) { 
            
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
        }

        public DbSet<User> Users { get; set; }
        public DbSet<Property> Properties { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<Neighborhood> Neighborhoods { get; set; }
        public DbSet<PropertyFile> Files { get; set; }
        public DbSet<Application> Applications { get; set; }
        public DbSet<Contract> Contracts { get; set; }
    }
}
