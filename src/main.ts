import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { frontendUrl, port } from 'utils/constants';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors({
    origin: `${frontendUrl}`, // Allow frontend origin (Next.js)
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true, // Allow cookies and authentication headers
  });

  const config = new DocumentBuilder()
    .setTitle('CORECLINIC')
    .setDescription('Coreclinic apis')
    .setVersion('1.0')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(port);
}
bootstrap();
