DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS recipe_steps CASCADE;
DROP TABLE IF EXISTS recipe_ingredients CASCADE;
DROP TABLE IF EXISTS recipe_categories CASCADE;
DROP TABLE IF EXISTS steps CASCADE;
DROP TABLE IF EXISTS ingredients CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS recipes CASCADE;

CREATE TABLE users
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE recipes
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    creator_id INTEGER REFERENCES users(id)
);

CREATE TABLE categories
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE ingredients
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(50)
);

CREATE TABLE steps
(
    id          SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE recipe_categories
(
    recipe_id   INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (recipe_id, category_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id),
    FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE recipe_ingredients
(
    recipe_id     INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity      FLOAT,
    unit          VARCHAR(50),
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id)
);

CREATE TABLE recipe_steps
(
    recipe_id  INTEGER NOT NULL,
    step_id    INTEGER NOT NULL,
    step_order INTEGER NOT NULL,
    PRIMARY KEY (recipe_id, step_order),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id),
    FOREIGN KEY (step_id) REFERENCES steps (id)
);

CREATE TABLE ratings
(
    id        SERIAL PRIMARY KEY,
    recipe_id INTEGER NOT NULL,
    user_id   INTEGER NOT NULL,
    rating    INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment   TEXT,
    FOREIGN KEY (recipe_id) REFERENCES recipes (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE favorites
(
    user_id   INTEGER NOT NULL,
    recipe_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (recipe_id) REFERENCES recipes (id)
);
