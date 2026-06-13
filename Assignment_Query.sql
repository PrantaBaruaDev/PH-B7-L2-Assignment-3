-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id serial,
    full_name varchar(80) not null,
    email varchar(150) not null,
    role varchar(20) not null,
    phone_number varchar(20),

    constraint pk_user_id primary key(user_id),
    constraint unique_email unique(email),
    constraint check_role_spacific check(role in ('Ticket Manager', 'Football Fan'))
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id serial,
    fixture varchar(150) not null,
    tournament_category varchar(100) not null,
    base_ticket_price decimal(10,2) not null,
    match_status varchar(20) not null,

    constraint pk_match_id primary key(match_id),
    constraint check_price_non_negative check(base_ticket_price > 0),
    constraint check_match_status check(match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id serial,
    user_id integer not null,
    match_id integer not null,
    seat_number varchar(10),
    payment_status varchar(10),
    total_cost decimal(10,2) not null,

    constraint pk_booking_id primary key(booking_id),
    constraint fk_Bookings_Users foreign key (user_id) references Users(user_id),
    constraint fk_Bookings_Matches foreign key (match_id) references Matches(match_id),
    constraint check_total_cost_non_negative check(total_cost > 0),
    constraint check_payment_status check(payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);

