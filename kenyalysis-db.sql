

CREATE TYPE user_role AS ENUM ('citizen', 'government_official', 'admin');
CREATE TYPE incident_status AS ENUM ('submitted', 'in_review', 'resolved', 'closed');

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Incidents (
    incident_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    category VARCHAR(255),
    description TEXT,
    location VARCHAR(255),
    media_url VARCHAR(255),
    status incident_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Polls (
    poll_id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    created_by INT NOT NULL,
    category VARCHAR(255),
    description TEXT,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

CREATE TABLE Poll_Options (
  option_id SERIAL PRIMARY KEY,
  poll_id INT NOT NULL,
  option_text VARCHAR(255) NOT NULL,
  FOREIGN KEY (poll_id) REFERENCES Polls(poll_id)
);

CREATE TABLE Poll_Votes (
    vote_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    poll_id INT NOT NULL,
    option_id INT NOT NULL,
    vote_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (poll_id) REFERENCES Polls(poll_id),
    FOREIGN KEY (option_id) REFERENCES Poll_Options(option_id)
);

CREATE TABLE Government_Documents (
    document_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    file_url VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Citizen_Feedback (
    feedback_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    document_id INT,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (document_id) REFERENCES Government_Documents(document_id)
);

CREATE TABLE Conversation_History (
    message_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    document_id INT NOT NULL,
    message TEXT NOT NULL,
    is_user BOOLEAN NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (document_id) REFERENCES Government_Documents(document_id)
);


























use KenyAlysisDB

CREATE TABLE users(
user_id (INT, Primary Key, Auto-Increment)

full_name (VARCHAR(255))

email (VARCHAR(255), Unique)

password_hash (VARCHAR(255)) // Hashed password, never store plain text!

role (ENUM('citizen', 'government_official', 'admin')) // Using ENUM for data integrity

created_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

updated_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
)


CREATE TABLE incident(
incident_id (INT, Primary Key, Auto-Increment)

user_id (INT, Foreign Key to Users table)

category (VARCHAR(255))

description (TEXT)

location (VARCHAR(255))

media_url (VARCHAR(255), NULLABLE) // URL to uploaded image/video (can be NULL)

status (ENUM('submitted', 'in_review', 'resolved', 'closed'))

created_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

updated_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
)


CREATE TABLE polls (
poll_id (INT, Primary Key, Auto-Increment)

question (TEXT)

start_date (TIMESTAMP)

end_date (TIMESTAMP)

created_by (INT, Foreign Key to Users table) //The user who created the poll (Admin)

category (VARCHAR(255), NULLABLE)

description (TEXT, NULLABLE)
)


CREATE TABLE poll-option(option_id (INT, Primary Key, Auto-Increment)

poll_id (INT, Foreign Key to Polls table)

option_text (VARCHAR(255)) // The actual option text for the poll.)


CREATE TABLE poll-votes(
vote_id (INT, Primary Key, Auto-Increment)

user_id (INT, Foreign Key to Users table)

poll_id (INT, Foreign Key to Polls table)

option_id (INT, Foreign Key to Poll_Options table) // Which option did the user vote for?

vote_timestamp (TIMESTAMP DEFAULT CURRENT_TIMESTAMP) //When the vote was recorded.
)

CREATE TABLE govt-document(
document_id (INT, Primary Key, Auto-Increment)

title (VARCHAR(255))

description (TEXT)

file_url (VARCHAR(255)) // URL to the document file

upload_date (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

created_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)

updated_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
)

CREATE TABLE citizen-feedback(
    feedback_id (INT, Primary Key, Auto-Increment)

user_id (INT, Foreign Key to Users table)

document_id (INT, Foreign Key to Government_Documents table, NULLABLE) //Optional: Link to a specific document.

comment (TEXT)

created_at (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
)

CREATE TABLE conversation-history(
    message_id (INT, Primary Key, Auto-Increment)

user_id (INT, Foreign Key to Users table)

document_id (INT, Foreign Key to Government_Documents table)

message (TEXT)

is_user (BOOLEAN) // TRUE if the message is from the user, FALSE if from the AI

timestamp (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
)