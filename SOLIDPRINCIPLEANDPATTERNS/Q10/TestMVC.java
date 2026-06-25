// ---------------- Model ----------------

class Student {

    private String name;
    private int id;
    private String grade;

    public Student(String name, int id, String grade) {
        this.name = name;
        this.id = id;
        this.grade = grade;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}

// ---------------- View ----------------

class StudentView {

    public void displayStudentDetails(Student student) {

        System.out.println("Student Details");
        System.out.println("----------------------");
        System.out.println("Name  : " + student.getName());
        System.out.println("ID    : " + student.getId());
        System.out.println("Grade : " + student.getGrade());

    }

}

// ---------------- Controller ----------------

class StudentController {

    private Student model;
    private StudentView view;

    public StudentController(Student model, StudentView view) {

        this.model = model;
        this.view = view;

    }

    public void setStudentName(String name) {

        model.setName(name);

    }

    public void setStudentGrade(String grade) {

        model.setGrade(grade);

    }

    public void updateView() {

        view.displayStudentDetails(model);

    }

}

// ---------------- Main Class ----------------

public class TestMVC {

    public static void main(String[] args) {

        // Create Model
        Student student =
                new Student("Namish", 101, "A");

        // Create View
        StudentView view =
                new StudentView();

        // Create Controller
        StudentController controller =
                new StudentController(student, view);

        System.out.println("Initial Student Details");

        controller.updateView();

        System.out.println();

        // Update Student Details
        controller.setStudentName("Rahul");
        controller.setStudentGrade("A+");

        System.out.println("Updated Student Details");

        controller.updateView();

    }

}