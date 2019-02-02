#!/bin/bash

# docker networks that should be available across compose stacks
networks=( proxy phpmyadmin mail )

for i in "${networks[@]}"
do
	docker network create $i
done
