CREATE TABLE "client_applications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "url" varchar(255), "support_url" varchar(255), "callback_url" varchar(255), "key" varchar(50), "secret" varchar(50), "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "oauth_nonces" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "nonce" varchar(255), "timestamp" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "oauth_tokens" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "type" varchar(20), "client_application_id" integer, "token" varchar(50), "secret" varchar(50), "authorized_at" datetime, "invalidated_at" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login" varchar(40), "name" varchar(100) DEFAULT '', "email" varchar(100), "crypted_password" varchar(40), "salt" varchar(40), "created_at" datetime, "updated_at" datetime, "remember_token" varchar(40), "remember_token_expires_at" datetime);
CREATE UNIQUE INDEX "index_client_applications_on_key" ON "client_applications" ("key");
CREATE UNIQUE INDEX "index_oauth_nonces_on_nonce_and_timestamp" ON "oauth_nonces" ("nonce", "timestamp");
CREATE UNIQUE INDEX "index_oauth_tokens_on_token" ON "oauth_tokens" ("token");
CREATE UNIQUE INDEX "index_users_on_login" ON "users" ("login");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090116042224');

INSERT INTO schema_migrations (version) VALUES ('20090116044801');