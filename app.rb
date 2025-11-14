require 'sinatra'
require 'json'
require 'sequel'

DB = Sequel.sqlite('todos.db') # SQLite file

# Create todos table if it doesn't exist
DB.create_table? :todos do
  primary_key :id
  String :task
  Boolean :done, default: false
end

todos = DB[:todos]

# Serve UI
get '/' do
  erb :index
end

# API: Get all todos
get '/api/todos' do
  todos.all.to_json
end

# API: Create a todo
post '/api/todos' do
  payload = JSON.parse(request.body.read)
  id = todos.insert(task: payload['task'])
  todos.where(id: id).first.to_json
end

# API: Update a todo (toggle done)
put '/api/todos/:id' do
  id = params[:id].to_i
  payload = JSON.parse(request.body.read)
  todos.where(id: id).update(task: payload['task'], done: payload['done'])
  todos.where(id: id).first.to_json
end

# API: Delete a todo
delete '/api/todos/:id' do
  id = params[:id].to_i
  todos.where(id: id).delete
  { status: 'deleted' }.to_json
end

__END__

@@index
<!DOCTYPE html>
<html>
<head>
  <title>Todo App</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f4f9; margin: 0; padding: 20px; }
    h1 { text-align: center; color: #333; }
    #todo-container { max-width: 500px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);}
    ul { list-style: none; padding: 0; }
    li { display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #ddd; }
    li.done span { text-decoration: line-through; color: #888; }
    button { margin-left: 5px; padding: 3px 6px; border: none; border-radius: 5px; cursor: pointer; }
    .delete-btn { background: #e74c3c; color: white; }
    .done-btn { background: #2ecc71; color: white; }
    #todo-input { width: 70%; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
    #add-btn { padding: 8px 12px; border-radius: 5px; background: #3498db; color: white; border: none; cursor: pointer; }
  </style>
</head>
<body>
  <h1>Todo List</h1>
  <div id="todo-container">
    <ul id="todo-list"></ul>
    <input type="text" id="todo-input" placeholder="New todo"/>
    <button id="add-btn" onclick="addTodo()">Add</button>
  </div>

  <script>
    async function fetchTodos() {
      const res = await fetch('/api/todos');
      const todos = await res.json();
      const list = document.getElementById('todo-list');
      list.innerHTML = '';

      todos.forEach(todo => {
        const li = document.createElement('li');
        li.className = todo.done ? 'done' : '';

        const span = document.createElement('span');
        span.textContent = todo.task;

        const doneBtn = document.createElement('button');
        doneBtn.textContent = todo.done ? 'Undo' : 'Done';
        doneBtn.className = 'done-btn';
        doneBtn.onclick = async () => {
          await fetch(`/api/todos/${todo.id}`, {
            method: 'PUT',
            headers: {'Content-Type':'application/json'},
            body: JSON.stringify({task: todo.task, done: !todo.done})
          });
          fetchTodos();
        };

        const deleteBtn = document.createElement('button');
        deleteBtn.textContent = 'Delete';
        deleteBtn.className = 'delete-btn';
        deleteBtn.onclick = async () => {
          await fetch(`/api/todos/${todo.id}`, { method: 'DELETE' });
          fetchTodos();
        };

        li.appendChild(span);
        li.appendChild(doneBtn);
        li.appendChild(deleteBtn);
        list.appendChild(li);
      });
    }

    async function addTodo() {
      const input = document.getElementById('todo-input');
      if(input.value.trim() === '') return;
      await fetch('/api/todos', {
        method: 'POST',
        headers: {'Content-Type':'application/json'},
        body: JSON.stringify({task: input.value})
      });
      input.value = '';
      fetchTodos();
    }

    fetchTodos();
  </script>
</body>
</html>
