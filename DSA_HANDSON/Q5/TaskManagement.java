class Task {

    int taskId;
    String taskName;
    String status;

    Task next;

    public Task(int taskId, String taskName, String status) {

        this.taskId = taskId;
        this.taskName = taskName;
        this.status = status;
        this.next = null;

    }

    public void display() {

        System.out.println(taskId + " " + taskName + " " + status);

    }
}
public class TaskManagement {

    Task head = null;

    // Add Task

    public void addTask(Task newTask) {

        if (head == null) {

            head = newTask;

            return;

        }

        Task temp = head;

        while (temp.next != null)

            temp = temp.next;

        temp.next = newTask;

    }

    // Search Task

    public Task searchTask(int id) {

        Task temp = head;

        while (temp != null) {

            if (temp.taskId == id)

                return temp;

            temp = temp.next;

        }

        return null;

    }

    // Traverse List

    public void displayTasks() {

        Task temp = head;

        while (temp != null) {

            temp.display();

            temp = temp.next;

        }

    }

    // Delete Task

    public void deleteTask(int id) {

        if (head == null) {

            System.out.println("List Empty");

            return;

        }

        if (head.taskId == id) {

            head = head.next;

            System.out.println("Task Deleted");

            return;

        }

        Task current = head;

        while (current.next != null && current.next.taskId != id)

            current = current.next;

        if (current.next == null) {

            System.out.println("Task Not Found");

            return;

        }

        current.next = current.next.next;

        System.out.println("Task Deleted");

    }

    public static void main(String[] args) {

        TaskManagement obj = new TaskManagement();

        obj.addTask(new Task(101, "Design UI", "Pending"));

        obj.addTask(new Task(102, "Develop Backend", "In Progress"));

        obj.addTask(new Task(103, "Testing", "Pending"));

        System.out.println("Task List");

        obj.displayTasks();

        System.out.println("\nSearching Task");

        Task t = obj.searchTask(102);

        if (t != null)

            t.display();

        obj.deleteTask(102);

        System.out.println("\nAfter Deletion");

        obj.displayTasks();

    }

}