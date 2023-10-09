
# Pokemon - Clean Architecture(Flutter)

## BeAware 

## Why Clean Architecture?
## Pros 
* The most powerful software design
* Promotes the separation of concerns
* Highly maintainable, testable and flexible
* Divide codebase into independent layers that communicate through defined interfaces.
* Learning ability of concepts and principle increase

## Cons
* Need more planning and design
* Complexity increase (in small projects)
* Time consuming

# When To Use?
* To practice the new way of building the complex and highly maintanable application
* When to create complex and robust projects
* When having multi-concerns in one project

## *-----------Now When You finally Dicided to go with Clean Architecture----------*
## Lets Gets Started

## Skeleton
Presentation: 
* UI & UX 
    * Pages
    * Provider (State management : BLOC , Riverpod...)
    * Widgets
Business(Domain): 
* Logics, implementation details, logs, exeptions, rules
    * entities
    * repositories 
    * usecases
Data: 
* Internal & external data (api / datastore)
    * datasources (Remote/Locale)
    * models
    * repositories 

![image](https://github.com/Abhishek24v/Pokemon-Clean_Architecture/assets/88134020/fe447bf4-7bd8-41d6-ba4c-5b5d99662e5d)

## Let's Divide & Rule over it 🔨 

* Let's be more specific to our project now!
 
## Presentation layer 

* Handles the landing Screen which shows the pokemon image, name and properties.
* Also holds the state management tool (Provider). There are multiple state management libraries, but will discuss some more commonly used like Riverpod, Provider, Bloc etc.
* Widgets are the visible Ui components used in the primary Ui screens, widget is a fundamental building block of your user interface. 

                           Pages 
                            👇 
                          Widgets -> (Click the button)
                            👇 
                    <-     Entity    ->
            Yes                          No
             👇                          👇   
       Show Widget              <- Check for Failure ->
                            Yes                         No
                            👇                          👇 
                        error Message               show Loading



* The logic is to either get entity(data) or failure.


## Domain Layer (Business)

* You can say, it's a bridge between the presentation and the data layer. 

                    Input from Ui(events)
                           👇👆 
                         Usecases
                           👇👆  
            Triggers the repositories (using entity)
                           👇👆 
                        Data Layer



Navigate to -> Lib/core/template/info_feature.txt

