class Employee {

    int employeeId;
    String name;
    String position;
    double salary;

    public Employee(int employeeId, String name, String position, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }

    public void display() {
        System.out.println(employeeId + " " + name + " " + position + " " + salary);
    }
}
public class EmployeeManagement {

    Employee[] employees = new Employee[10];

    int size = 0;

    // Add Employee

    public void addEmployee(Employee emp) {

        if (size < employees.length) {

            employees[size] = emp;

            size++;

            System.out.println("Employee Added.");

        } else {

            System.out.println("Array is Full.");

        }

    }

    // Search Employee

    public Employee searchEmployee(int id) {

        for (int i = 0; i < size; i++) {

            if (employees[i].employeeId == id)

                return employees[i];

        }

        return null;
    }

    // Traverse Employees

    public void displayEmployees() {

        for (int i = 0; i < size; i++) {

            employees[i].display();

        }

    }

    // Delete Employee

    public void deleteEmployee(int id) {

        int index = -1;

        for (int i = 0; i < size; i++) {

            if (employees[i].employeeId == id) {

                index = i;

                break;

            }

        }

        if (index == -1) {

            System.out.println("Employee Not Found.");

            return;

        }

        // Shift elements left

        for (int i = index; i < size - 1; i++) {

            employees[i] = employees[i + 1];

        }

        employees[size - 1] = null;

        size--;

        System.out.println("Employee Deleted.");
    }

    public static void main(String[] args) {

        EmployeeManagement obj = new EmployeeManagement();

        obj.addEmployee(new Employee(101, "Alice", "Manager", 70000));

        obj.addEmployee(new Employee(102, "Bob", "Developer", 60000));

        obj.addEmployee(new Employee(103, "Charlie", "Tester", 50000));

        System.out.println("\nEmployee List");

        obj.displayEmployees();

        System.out.println("\nSearching Employee");

        Employee e = obj.searchEmployee(102);

        if (e != null)

            e.display();

        obj.deleteEmployee(102);

        System.out.println("\nAfter Deletion");

        obj.displayEmployees();

    }

}