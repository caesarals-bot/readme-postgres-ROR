rails g model User name:string email:string 

rails db:migrate
rails db:migrate:status

crear en postgres
rails db:create

rails db:migrate:status
rails g scaffold factory name address    


rails new farmers --database=postgresql
rails db:create
rails g model farmer name age
rails g scaffold Animal name 
rails g migration addFarmersToAnimals farmer:references
rails db:seed 
--verificando rutas 
rails routes --expanded

--revirtiendo migration para ejecutar nuevos cambios con el db:migration
rails db:rollback

--Buscar en la tabla consola
Article.find()
Article.first
Article.last
--To find an article by id you can use the find method like below:

Article.find(1) # replace 1 with id of article you want to find

--You can save this to a variable and use it like below

article = Article.find(1)
article.title # to display (get) the title
article.description # to display (get) the description

--You can use the methods below to view the first and last articles of the articles table:

Article.first # display the first article in the articles table
Article.last # display the last article in the articles table

--You can update an article by finding it first and then using setters for the attributes that the model provides like below:

article = Article.find(id of article you want to edit)
article.title = "new title"
article.description = "new description"
article.save

--You can delete an article by using the destroy method. A sample sequence could be like below:

article = Article.find(id of article you want to delete)
article.destroy