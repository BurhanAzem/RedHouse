using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RedHouse_Server.Migrations
{
    /// <inheritdoc />
    public partial class lastEditModel_2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TimeStamp",
                table: "UserHistoryRecords");

            migrationBuilder.RenameColumn(
                name: "CreatedDate",
                table: "Contracts",
                newName: "StartDate");

            migrationBuilder.AddColumn<DateTime>(
                name: "EndDate",
                table: "Contracts",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.CreateIndex(
                name: "IX_UserHistoryRecords_ContractId",
                table: "UserHistoryRecords",
                column: "ContractId");

            migrationBuilder.AddForeignKey(
                name: "FK_UserHistoryRecords_Contracts_ContractId",
                table: "UserHistoryRecords",
                column: "ContractId",
                principalTable: "Contracts",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserHistoryRecords_Contracts_ContractId",
                table: "UserHistoryRecords");

            migrationBuilder.DropIndex(
                name: "IX_UserHistoryRecords_ContractId",
                table: "UserHistoryRecords");

            migrationBuilder.DropColumn(
                name: "EndDate",
                table: "Contracts");

            migrationBuilder.RenameColumn(
                name: "StartDate",
                table: "Contracts",
                newName: "CreatedDate");

            migrationBuilder.AddColumn<DateTime>(
                name: "TimeStamp",
                table: "UserHistoryRecords",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
