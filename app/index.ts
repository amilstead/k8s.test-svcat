import { app, bootstrap } from './simple-service';

const port = process.env.PORT;

app.listen(port, async function() {
  await bootstrap();
  console.log(`simple-service listening on port ${port}!`);
});
