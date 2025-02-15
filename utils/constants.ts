export const port = process.env.APP_PORT ?? 3030;
export const frontendUrl = process.env.FRONTEND_URL;

export const jwtSecret = process.env.JWT_SECRET;
export const jwtExpIn = process.env.JWT_EXP_IN;
export const jwtRefreshSecret = process.env.JWT_REFRESH_SECRET;
export const jwtRefreshExpIn = process.env.JWT_REFRESH_EXP_IN;

export const databaseHost = process.env.POSTGRES_HOST;
export const databaseUser = process.env.POSTGRES_USER;
export const databasePassword = process.env.POSTGRES_PASSWORD;
export const databaseName = process.env.POSTGRES_DB;
export const databaseUrl = process.env.DATABASE_URL;
