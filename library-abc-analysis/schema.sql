CREATE TABLE readers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    phone TEXT,
    email TEXT UNIQUE,
    reg_date DATE DEFAULT CURRENT_DATE
);
 
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT,
    year INTEGER,
    price NUMERIC(10,2),
    total_copies INTEGER DEFAULT 1
);
 
CREATE TABLE loans (
    id SERIAL PRIMARY KEY,
    reader_id INTEGER NOT NULL REFERENCES readers(id),
    book_id INTEGER NOT NULL REFERENCES books(id),
    loan_date DATE NOT NULL,
    return_date DATE,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'returned'))
);
