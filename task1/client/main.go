package main

import (
	"context"
	"log"
	sw "webapp/client/swagger"

	"github.com/antihax/optional"
)

func main() {
	ctx := context.Background()

	body := sw.UserCreateBody{
		Email:    "test@test.com",
		Password: "test",
		Nickname: "test",
	}

	client := sw.NewAPIClient(sw.NewConfiguration())
	client.ChangeBasePath("http://localhost:8080/api")
	user, resp, err := client.UserApi.UserCreatePost(ctx, &sw.UserApiUserCreatePostOpts{Body: optional.NewInterface(body)})
	if err != nil {
		log.Fatal(err)
	}

	log.Println(resp.StatusCode)
	log.Println(user.Id)
}
