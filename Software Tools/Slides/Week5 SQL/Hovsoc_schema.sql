-- Drop table if they exist (reverse order of creation)
DROP TABLE IF EXISTS Attendence;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Member;

-- Create table in the correct order
-- Member table
CREATE TABLE Member (
    ContactEmail VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    StudentNumber VARCHAR(255),
    HoverboardRidingSkillLevel INT CHECK (HoverboardRidingSkillLevel >= 0),
    UniqueCommitteeRole VARCHAR(255) UNIQUE
);

-- Event table
CREATE TABLE Event (
    Date DATE,
    Location VARCHAR(255),
    Name VARCHAR(255),
    Description TEXT,
    Organizer VARCHAR(255) NOT NULL,
    PRIMARY KEY (Date, Location),
    FOREIGN KEY (Organizer) REFERENCES Member(ContactEmail)
);

-- Attendence associative table for the many-to-many relationship
CREATE TABLE Attendence (
    MemberEmail VARCHAR(255),
    EventDate DATE,
    EventLocation VARCHAR(255),
    PRIMARY KEY (MemberEmail, EventDate, EventLocation),
    FOREIGN KEY (MemberEmail) REFERENCES Member(ContactEmail),
    FOREIGN KEY (EventDate, EventLocation) REFERENCES Event(Date, Location)
);
