# Define the Requirements

This is the first exercise of the course. I will work with one of the sample projects described in the course: a Web Site. 

The Web Site will be a potential use case for a Network Consultant that will be offering Professional Services and Training in the next months.

## Cloud Provider

Amazon Web Services (AWS) is the Cloud Provider chosen for the course. As it is one of the most used by the customers, my intention is to learn "cloud skills" with AWS as starting point then, when I´ll be fluent with AWS, jump into other providers like Google or Azure. I like to learn technology doing analogies. For example, learning networking with Cisco and then, once I´ve mastered the protocols, jump into Juniper. 

## Requirements

In this section there are a list of questions, answering the questions will (hopefully) describe the requirements.

In terms of requirements, I will do my best to describe the facts: going to reality and see what I really need. I will avoid as much as I can the typical mistake of choosing first solutions, best practices, recipes...before describing the current situation. Then, after describing the current situation (WHAT), I will go ahead and I will try to discern between the different options (WHY). Finally, I will think about everything related to the HOW.

There are several ways to categorize the requirements. For example, one very common is to differentiate between functional and non-functional requirements. I think that, like in many other things in Networking/IT (MPLS is tunneling or encapsulation? should we use the term load-sharing or load-balancing ? job descriptions like Architect, Sr and so on..) the term requirement is vague, imprecise. From my experience, what I have seen is that it is typically said or understood as everything that the customer wants (a mix of needs and wishes), regardless if it is actually relevant or not from the technological perspective to what it is really needed from the business standpoint (proper needs). 

I will do a different categorization, using the Aristotle´s terms essence and accident, to differentiate between requirements that are essential or not.
Essence: property or set of properties that make an entity or substance what it fundamentally is, and which it has by necessity, and without it loses its identity.
Accident: an attribute that may nor may not belong to a subject, without affecting its essence.

### What services should the public cloud deployment offer to the customers?

As the consultant is just starting as a freelancer, the target is to advertise himself in Internet and to provide the information needed like experience and his technical skills, so potential customers could contract him. He is doing projects and courses regularly.

The public cloud deployment will offer a public web site.
The content will be updated regularly. However, as it is a simple website, the content will be static.

### How will the users consume those services? Will they use Internet access or will you have to provide a more dedicated connectivity solution?

The users will connect through Internet.

### Identify the data needed by the solution you're deploying. What data is shared with other applications? Where will the data reside?

All of the data will be related to the website.
The data will reside in a back-end database. There is not enough information to figure out if it would be better to choose a Transactional
vs non-Transactional Database at the moment. Therefore, KISS rule will be followed to choose one or another.

### What are the security requirements of your application?

There will be authorization implemented in order to provide write access to the site admin.
As the business (consultant´s job) is not impacted in case the site is compromised, there´s no specific security requirements. 
The basic security common rules of changing the passwords periodically, minimal password strength, periodic updates, ACLs will be configured they are easy to manage and it adds a simple layer of security.   

### What are the high availability requirements?

There are no high availability requirements. In case there is an outage, the business will not suffer.

### Do you have to provide connectivity to your on-premises data center? If so, how will you implement it?

It´s out of the scope of the project.

### Do you have to implement connectivity to other (customer) sites? If so, how will you implement it?

It´s out of the scope of the project.

## Requirements Classification

The essential requirements are:

* Web service
* Internet Connectivity
* Database

The non-essential (accidents) requirements are:

* Security
* Back-end Database
* Type of Database: Transactional vs non-transactional




    
    
    
    
    
  
    
