WITH RECURSIVE EmployeeHierarchy AS (
    
    SELECT 
        e.EmployeeID, 
        e.Name AS EmployeeName, 
        e.ManagerID, 
        d.DepartmentName, 
        r.RoleName
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    JOIN Roles r ON e.RoleID = r.RoleID
    WHERE e.EmployeeID = 1  

    UNION ALL

    
    SELECT 
        e.EmployeeID, 
        e.Name AS EmployeeName, 
        e.ManagerID, 
        d.DepartmentName, 
        r.RoleName
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    JOIN Roles r ON e.RoleID = r.RoleID
)

SELECT 
    eh.EmployeeID,
    eh.EmployeeName,
    eh.ManagerID,
    eh.DepartmentName,
    eh.RoleName,
    COALESCE(string_agg(DISTINCT p.ProjectName, ', '), NULL) AS ProjectNames,
    COALESCE(string_agg(DISTINCT t.TaskName, ', '), NULL) AS TaskNames
FROM EmployeeHierarchy eh
LEFT JOIN Projects p ON eh.DepartmentName = (SELECT DepartmentName FROM Departments WHERE DepartmentID = p.DepartmentID)
LEFT JOIN Tasks t ON eh.EmployeeID = t.AssignedTo
GROUP BY eh.EmployeeID, eh.EmployeeName, eh.ManagerID, eh.DepartmentName, eh.RoleName
ORDER BY eh.EmployeeName;
