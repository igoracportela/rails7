## Tasks:

- Create a CRUD of cities (Except delete).
- The citizen has active and inactive status.
- Ideally it only needs to be 2 pages
- CRUD listing (with options to browse), and the registration itself. 2 pages is just a suggestion, you are free to assemble the UI/UX as you see fit.

- Have a related entity called municipe. This entity registers citizens (people) within a municipality. The following rules must be followed:

- Citizen data: `Full name, CPF, CNS (national health card), Email, Date of birth, Telephone (country code and area code), Photo and status`.

- All citizen data is mandatory;

- `CPF, CNS, Email` must be valid;

- Pay attention to the date of birth. Validate cases that are impossible/unlikely to be valid;

- Citizen's photo must be different sizes to suit various cases.

- Have a related entity called Address.
- This entity saves the address related to the citizen. The following rules must be followed:

- Fields `Zipcode, street, complement, neighborhood, city, state and IBGE`;

- All data are mandatory, except complement and IBGE code;

- In terms of MVC, there is only the Entity relational address. The rest is expendable;

- After creating/updating a citizen, you must send an email and sms to the same informing about the registration of your information and when your status changes;

- Filter citizens by their and/or address data. The choice of what to do is free.

- It is possible to optimize the address registration time from the UX.

- You should minimize user navigation as much as possible. How would you do it?

- Think that these rules can be changed very often;
- We like optimization, setups and deploys are always automated (Docker?)
- It goes without saying that you need to test most files, do I?
- Design principles and standards are very welcome and essential for Seniors;
- Reducing the number of calls to the database is essential.
- Ruby, Ruby on Rails and Postgres are required;
- Elasticsearch/Kafka (optional, plus);
- Use ActionView, however, AssetPipeline/Sprockets or a SPA approach with rails;



## Tools
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

    ## APIs
        - Cpf: hubdodeveloper
        - Zip code: hubdodeveloper
        - SMS: textbelt
        - Email: sendinblue
        - Hosting: heroku
        - Git: github

    For local execution, enable cache => rails dev:cache
