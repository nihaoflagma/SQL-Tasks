WITH RECURSIVE EmployeeHierarchy AS (
    
    SELECT 
        e.EmployeeID,
        e.Name AS EmployeeName,
        e.ManagerID,
        e.DepartmentID,
        d.DepartmentName,
        r.RoleName,
        0 AS TotalSubordinates
    FROM Employees e
    JOIN Roles r ON e.RoleID = r.RoleID
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE r.RoleName LIKE 'Менеджер'

    UNION ALL

    
    SELECT 
        e.EmployeeID,
        e.Name AS EmployeeName,
        e.ManagerID,
        e.DepartmentID,
        d.DepartmentName,
        r.RoleName,
        eh.TotalSubordinates + 1 AS TotalSubordinates
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
    JOIN Roles r ON e.RoleID = r.RoleID
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
)

SELECT 
    eh.EmployeeID,
    eh.EmployeeName,
    eh.ManagerID,
    eh.DepartmentName,
    eh.RoleName,
    COALESCE(string_agg(DISTINCT p.ProjectName, ', '), NULL) AS ProjectNames,
    COALESCE(string_agg(DISTINCT t.TaskName, ', '), NULL) AS TaskNames,
    COUNT(DISTINCT e.EmployeeID) AS TotalSubordinates
FROM EmployeeHierarchy eh
LEFT JOIN Employees e ON e.ManagerID = eh.EmployeeID
LEFT JOIN Projects p ON p.DepartmentID = eh.DepartmentID
LEFT JOIN Tasks t ON t.AssignedTo = eh.EmployeeID
WHERE eh.EmployeeID = 4 
GROUP BY eh.EmployeeID, eh.EmployeeName, eh.ManagerID, eh.DepartmentName, eh.RoleName
ORDER BY eh.EmployeeName;
