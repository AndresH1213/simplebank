DB_URL=postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable

postgres:
	docker run --name go-course-postgres --network bank-network -p 5432:5432 -e POSTGRES_USERNAME=postgres -e POSTGRES_PASSWORD=secret -d postgres:16.12-alpine3.22

createdb:
	docker exec -it go-course-postgres createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it go-course-postgres dropdb --username=postgres --owner=postgres simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" down 1

sqlc:
	sqlc generate

test:
	go test ./...

test-no-cache:
	go test -v -cover -count=1 ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/AndresH1213/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test test-no-cache server mock