postgres:
	docker run --name go-course-postgres -p 5432:5432 -e POSTGRES_USERNAME=postgres -e POSTGRES_PASSWORD=secret -d postgres:16.12-alpine3.22

createdb:
	docker exec -it go-course-postgres createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it go-course-postgres dropdb --username=postgres --owner=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

test-no-cache:
	go test -v -cover -count=1 ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test test-no-cache