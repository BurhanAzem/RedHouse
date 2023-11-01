using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RedHouse_Server.Migrations
{
    /// <inheritdoc />
    public partial class lastEditModeln : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_Files",
                table: "Files");

            migrationBuilder.RenameTable(
                name: "Files",
                newName: "PropertyFiles");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PropertyFiles",
                table: "PropertyFiles",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_PropertyFiles_PropertyId",
                table: "PropertyFiles",
                column: "PropertyId");

            migrationBuilder.AddForeignKey(
                name: "FK_PropertyFiles_Properties_PropertyId",
                table: "PropertyFiles",
                column: "PropertyId",
                principalTable: "Properties",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PropertyFiles_Properties_PropertyId",
                table: "PropertyFiles");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PropertyFiles",
                table: "PropertyFiles");

            migrationBuilder.DropIndex(
                name: "IX_PropertyFiles_PropertyId",
                table: "PropertyFiles");

            migrationBuilder.RenameTable(
                name: "PropertyFiles",
                newName: "Files");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Files",
                table: "Files",
                column: "Id");
        }
    }
}
