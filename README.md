
# Sinatra Todo Microservice

A simple **Todo microservice** built with **Ruby, Sinatra, and SQLite3**.
Features:

* Add, delete, mark/unmark todos as done
* Minimal web UI
* Full REST API via `/api/todos`

---

## **Prerequisites**

* Ruby (3.x recommended)
* SQLite3
* Bundler (`gem install bundler`)
* Git (if cloning the repo)

---

## **Installation & Setup**

### **Windows**

1. **Install Ruby**

   * Download [RubyInstaller](https://rubyinstaller.org/) and follow the setup.
   * During installation, check **“Add Ruby executables to your PATH”**.

2. **Verify Ruby**

   ```powershell
   ruby -v
   ```

3. **Install Bundler**

   ```powershell
   gem install bundler
   bundler -v
   ```

4. **Install SQLite3**

   * Download [SQLite3 Windows binaries](https://www.sqlite.org/download.html)
   * Add the folder containing `sqlite3.exe` to your PATH
   * Verify:

     ```powershell
     sqlite3 --version
     ```

5. **Clone this repo**

   ```powershell
   git clone https://github.com/yourusername/sinatra-todo.git
   cd sinatra-todo
   ```

6. **Install dependencies**

   ```powershell
   bundle install
   ```

7. **Run the Sinatra microservice**

   ```powershell
   ruby app.rb
   ```

   * By default: `http://localhost:4567`
   * Open in browser to see the UI

---

### **Linux (Ubuntu/Debian)**

1. **Update packages**

   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

2. **Install Ruby and build tools**

   ```bash
   sudo apt install ruby-full build-essential -y
   ruby -v
   ```

3. **Install Bundler**

   ```bash
   gem install bundler
   bundler -v
   ```

4. **Install SQLite3**

   ```bash
   sudo apt install sqlite3 libsqlite3-dev -y
   sqlite3 --version
   ```

5. **Clone this repo**

   ```bash
   git clone https://github.com/yourusername/sinatra-todo.git
   cd sinatra-todo
   ```

6. **Install dependencies**

   ```bash
   bundle install
   ```

7. **Run the Sinatra microservice**

   ```bash
   ruby app.rb -o 0.0.0.0
   ```

   * Accessible from other machines at `http://<linux-ip>:4567`

---

## **API Endpoints**

| Method | Endpoint         | Description                       |
| ------ | ---------------- | --------------------------------- |
| GET    | `/api/todos`     | List all todos                    |
| POST   | `/api/todos`     | Add a new todo (`{"task":"..."}`) |
| PUT    | `/api/todos/:id` | Update todo (mark done/undo)      |
| DELETE | `/api/todos/:id` | Delete a todo                     |

---

## **UI Usage**

* Open `http://localhost:4567` in your browser
* Add todos using input box and “Add” button
* Mark todos as done with the **Done** button
* Delete todos with the **Delete** button

---

## **Optional**

* Use **screen/tmux** on Linux to keep the app running in background
* Use **SQLite Browser** to inspect your database (`todos.db`)

  Your AWS credentials have been activated for today for testing purposes.
Please log in to your AWS account using the following link:

🔗 https://vforesee.signin.aws.amazon.com/console

Use the credentials provided in here:
IAM username: 2401055
Password: QjQ4[=%}K35_jn1[I5y=

⚠️ Important:
Do not create, modify, or delete any AWS resources

