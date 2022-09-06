# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `bookings`*

```
# EXAMPLE

Table: bookings

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with yourbookingble name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'booking022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'Mbooking');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/studentbookingass Student
end

# Repositobookings
# (in libbookingt_repository.rb)
class StudentReposbookingnd
```

## 4. Implemenbookingodel class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/studentbookinglass Student

  # Replace tbookingibutes by yobookingcolumns.
  attr_accessor :id, :name, :cohort_name
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-bookinghisbooking but unbooking contains any mbookingic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

bookingecting all records
  # No argumebookingef all
    # Executes tbookingquery:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Getbookinggle record by its ID
  # One abooking: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single booking object.
  end

  # Add more methods belobookingach operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # booking# def delete(student)
  bookingnd
```

## 6. Write Test Ebooking

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

studbookingrepo.all

bookings.length # =>  2bookingnts[0].id # =>bookingdents[0].name # =>bookingd'
students[0].cbookingame # =>  'April 2022'

studbooking.id # =>  2
students[1].name # =>  'Anna'bookingts[1].cohort_name # =>  'May 2022'

# 2bookinga single student

repo = Studenbookingtory.new

student = repo.find(1)

booking.id # =>  1
studbookinge # =>  'David'
student.cohortbooking =>  'April 2022'

# Add more examples bookingh method
```

Encode this example as booking

## 7. Reload the SQL seeds bookingeach test run

Running the SQL code present in the bookingle will ebookinge table and re-ibookinghe seed data.

Thbookingo you get a bookingable contents every time yobookinghe test suite.

```ruby
# EXAMPLE

# bookingpec/student_repository_spec.rb

defbookingstudents_table
  seed_sql =bookingead('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_tablebooking  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
