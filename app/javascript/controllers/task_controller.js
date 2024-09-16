// import { Controller } from "@hotwired/stimulus"
import ApplicationController from './application_controller'
// Connects to data-controller="task"
export default class extends ApplicationController {
  static targets= ["title", "description","userId" ]
  
  submit(event) {
    event.preventDefault(); // Prevent default form submission behavior
    const submit_button = event.target;
    // Retrieve target elements from the form using dataset attributes
    const task_description_id = event.target.dataset.descriptionTarget;
    const task_title_id = event.target.dataset.titleTarget;
    const task_user_id = event.target.dataset.userIdTarget;
  
    // Get form input values
    const task_title = document.getElementById(task_title_id).value;
    const task_description = document.getElementById(task_description_id).value;
    const user_id = +document.getElementById(task_user_id).value;
  
    // Prepare data to send in the POST request
    const data = {
      task: {
        title: task_title,
        description: task_description,
        user_id: user_id
      }
    };
  
    // Send a POST request to create the task
    fetch('/tasks', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(async (data) => {
      if (data.id) {
        console.log('Task created successfully:', data);
  
        // Clear the form inputs after task creation
        document.getElementById(task_title_id).value = "";
        document.getElementById(task_description_id).value = "";
  
        // Get the table body to append a new row
        const tableBody = document.getElementById("updateTaskForm").querySelector("tbody");
  
        // Create a new table row
        const newRow = document.createElement("tr");
  
        // Create table cells and append them to the new row
        const titleCell = document.createElement("th");
        titleCell.scope = "row";
        titleCell.textContent = data.title;
        newRow.appendChild(titleCell);
  
        const descriptionCell = document.createElement("td");
        descriptionCell.textContent = data.description;
        newRow.appendChild(descriptionCell);
  
        const userCell = document.createElement("td");
        newRow.appendChild(userCell);
  
        try {
          // Fetch the user email and update the user cell
          const userResponse = await fetch(`/tasks/${data.user_id}/find_user_email`, { method: 'GET' });
          const userData = await userResponse.json();
          console.log('User data:', userData);
          userCell.textContent = userData[0]['email'] || 'No email found';
        } catch (error) {
          console.error('Error fetching user email:', error);
          userCell.textContent = 'Error fetching email';
        }
  
        const dateCell = document.createElement("td");
        dateCell.textContent = data.created_at;        ; 
        newRow.appendChild(dateCell);
        
        const assignedCell = document.createElement("td");
        assignedCell.textContent = data.assigned?'Yes':'No';
        newRow.appendChild(assignedCell);
        submit_button.previousElementSibling.click();
        // Append the new row to the table body
        tableBody.appendChild(newRow);
      } else {
        console.error('Failed to create task:', data);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
  assign_task(event) {  
    event.preventDefault();
    const submit_button = event.target;
    const task_id = event.target.dataset.taskIdTarget;
    const user_id = event.target.dataset.userIdTarget;
    const owner_id = event.target.dataset.ownerIdTarget;
    const task_id_value = document.getElementById(task_id).value
    const user_id_value = document.getElementById(user_id).value
    const owner_id_value = document.getElementById(owner_id).value
    const data = {
      assigned_task: {
        user_id: user_id_value,
        owner_id: owner_id_value,
        task_id: task_id_value
      }
    };
    fetch(`/tasks/${task_id_value}/assign`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(async (data) => {
      if (data.id) {
        this.stimulate('Task#assigned_task', { data: JSON.stringify(data) });
        console.log('Task assigned successfully:', data);
        document.getElementById(task_id).value = "";
        document.getElementById(user_id).value = "";
        submit_button.previousElementSibling.click();
      } else {
        console.error('Failed to assigned task:', data);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
  
  targetContainer(id) {
    return this.element.querySelector(`#${id}`);
  }
       
  
}
