﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using TestPumox.Data;
using TestPumox.Models;

namespace TestPumox.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CompanyController : ControllerBase
    {
        private readonly TestPumoxContext _context;

        public CompanyController(TestPumoxContext context)
        {
            _context = context;
        }

        // GET: company
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Company>>> GetCompany()
        {
            // return await _context.Company.ToListAsync();
            return await _context.Company.Include(s => s.Employees).ToListAsync();
        }

        // GET: company/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Company>> GetCompany(long id)
        {
            var company = await _context.Company
                .Where(c => c.Id == id)
                .Include(c => c.Employees)
                .FirstOrDefaultAsync();

            if (company == null)
            {
                return NotFound();
            }

            return company;
        }

        // PUT: company/5
        [HttpPut("update/{id}")]
        public async Task<IActionResult> PutCompany(long id, Company company)
        {
            if (id != company.Id)
            {
                return BadRequest();
            }

            _context.Entry(company).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CompanyExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetCompany", new { id = company.Id }, "Id: " + company.Id + " updated");
        }

        // POST: company/create
        [HttpPost("create")]
        public async Task<ActionResult<Company>> PostCompany(Company company)
        {
            _context.Company.Add(company);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCompany", new { id = company.Id }, "Id: " + company.Id);
        }

        // POST: company/search
       
        [HttpPost("search")]
        public Task<ArrayList> SearchCompany(Search search)
        {
            var searchCompanies = _context.Company
                .Where(company => company.Name.Contains(search.Keyword))
                .Include(emp => emp.Employees);
            var searchCompaniesIds = searchCompanies.Select(c => c.Id);

            var searchEmployees = _context.Employee
                .Where(employee => ((employee.DateOfBirth >= search.EmployeeDateOfBirthFrom) &&
                                    (employee.DateOfBirth <= search.EmployeeDateOfBirthTo)) ||
                                    (employee.JobTitle == search.EmployeeJobTitles) ||
                                    (employee.FirstName.Contains(search.Keyword)) ||
                                    (employee.LastName.Contains(search.Keyword)));
            var searchEmployeesIds = searchEmployees.Select(emp => emp.CompanyId);

            var searchAllCompanyIds = searchCompaniesIds.Concat(searchEmployeesIds).ToList();

            ArrayList resultCompanies = new ArrayList();
            foreach (var id in searchAllCompanyIds)
            {
                var tempSearch = _context.Company
                    .Where(company => company.Id == id)
                    .Include(emp => emp.Employees);
                resultCompanies.Add(tempSearch);
            }

            return Task.FromResult(resultCompanies);
        }

        // DELETE: company/5
        [HttpDelete("delete/{id}")]
        public async Task<ActionResult<Company>> DeleteCompany(long id)
        {
            var company = await _context.Company.FindAsync(id);
            if (company == null)
            {
                return NotFound();
            }

            _context.Company.Remove(company);
            await _context.SaveChangesAsync();

            return Ok("Company with id " + company.Id + " removed");
        }

        private bool CompanyExists(long id)
        {
            return _context.Company.Any(e => e.Id == id);
        }
    }
}
