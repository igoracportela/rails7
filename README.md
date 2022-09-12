Challenge:
Ok - Create a CRUD of cities (Except delete).
Ok - The citizen has active and inactive status.
Ok - Ideally it only needs to be 2 pages
    Ok - CRUD listing (with options to browse), and the registration itself. 2 pages is just a suggestion, you are free to assemble the UI/UX as you see fit.

Ok - 1. Have a related entity called municipe. This entity registers citizens (people) within a municipality. The following rules must be followed:

Ok - 1.1 Citizen data:
    `Full name, CPF, CNS (national health card), Email, Date of birth, Telephone (country code and area code), Photo and status`.

Ok - 1.2 All citizen data is mandatory;

Ok - 1.3 `CPF, CNS, Email` must be valid;

Ok - 1.4 Pay attention to the date of birth. Validate cases that are impossible/unlikely to be valid;

Ok - 1.5 Citizen's photo must be different sizes to suit various cases.

Ok - 2.Have a related entity called Address.
    Ok - This entity saves the address related to the citizen. The following rules must be followed:

2.1 Fields:
    Ok - `Zipcode, street, complement, neighborhood, city, state and IBGE`;

Ok - 2.2 All data are mandatory, except complement and IBGE code;

Ok - 2.3 In terms of MVC, there is only the Entity relational address. The rest is expendable;

Business rules:
Ok - 1. After creating/updating a citizen, you must send an email and sms to the same informing about the registration of your information and when your status changes;

Ok - 2. Filter citizens by their and/or address data. The choice of what to do is free.

UI/UX:
Ok - 1. It is possible to optimize the address registration time from the UX.

Ok - 2. You should minimize user navigation as much as possible. How would you do it?

Backend:
Okay - 1. Think that these rules can be changed very often;

Ok - 2. We like optimization, setups and deploys are always automated (Docker?)

Ok - 3. It goes without saying that you need to test most files, do I?

Ok - 4. Design principles and standards are very welcome and essential for Seniors;

Ok - 5. Reducing the number of calls to the database is essential.


Tools:
Ok - · Ruby, Ruby on Rails and Postgres are required;

Ok - · Elasticsearch/Kafka (optional, plus);

Ok - · Use ActionView, however, AssetPipeline/Sprockets or a SPA approach with rails;



Considerations for implementing the challenge:

    tools
        - Ruby 3.0.3
        - Rails 7.0.3
        - Postgres 14
        - Algolia
        - Bootstrap
        - StimuJs
        - Hotwire
        - Kaminari
        - VIPs
        - Redis
        - RestClient
        - Hey
        - Figaro
        - Audited
        - TimeDifference
        - Rspec
        - Shoulda

    apis
        - Cpf: hubdodeveloper
        - Zip code: hubdodeveloper
        - SMS: textbelt
        - Email: sendinblue
        - Hosting: heroku
        - Git: github

Grades:
    For local execution, enable cache => rails dev:cache