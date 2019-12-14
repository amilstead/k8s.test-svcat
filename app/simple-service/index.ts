import express from 'express';
import 'reflect-metadata';
import { createConnection } from 'typeorm';
import { User } from './entity/User';

// Create a new express application instance
const app: express.Application = express();

async function bootstrapDb() {
  try {
    const connection = await createConnection({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: Number.parseInt(process.env.DB_PORT || '5432'),
      username: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: process.env.DB_NAME,
      entities: [User],
      synchronize: true,
      logging: false
    });
    console.log('Inserting a new user into the database...');
    const user = new User();
    user.firstName = 'Timber';
    user.lastName = 'Saw';
    user.age = 25;
    await connection.manager.save(user);
    console.log('Saved a new user with id: ' + user.id);

    console.log('Loading users from the database...');
    const users = await connection.manager.find(User);
    console.log('Loaded users: ', users);

    console.log('Here you can setup and run express/koa/any other framework.');
  } catch (error) {
    console.log(error);
  }
}

async function bootstrap() {
  await bootstrapDb();
}

app.get('/', async function(req, res) {
  console.log('request made!');
  res.send('Hello World!');
});

export { app, bootstrap };
