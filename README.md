# WSO2 Dockerfiles
WSO2 Dockerfiles define the resources and instructions to build the Docker images with the WSO2 products and runtime configurations.

## Modifications in this fork of official repo

- This uses a Centos 7 base box with Java preinstalled or quicker builds instead of Ubuntu as a base. And you don't have to install Java on each instance since the base now has it installed in the base image.
- I added a download script to the base box to download the wso2 application in the box building process. Each image's Dockerfile will execute this script to download the correct application for the box automatically on build, so you won't have to download each manually to the files folder like the original README in each folder suggests.
- In other words, no manual downloading and Centos instead of Ubuntu
- To build an image navigate to the folder in shell and run `./build.sh -v 1.1.0` replacing 1.1.0 with the version of the application. It is required and a pain in the ass and eventually want to default to the latest. In other words, although you don't have to go through the pain of filling out the form to download the file manually, you do have to go to the application download page to find the current version.
- Once built, navigate to the folder and run `./run.sh -v 1.1.o`, again the the got damned version number.

## Try it out

To try the WSO2 products on Docker simply follow the instructions in the README in the relevant product folder.

## Detailed Configuration

* [Introduction] (https://docs.wso2.com/display/DF120/Introduction)

* [Build docker images] (https://docs.wso2.com/display/DF120/Building+Docker+Images)

* [Run docker images] (https://docs.wso2.com/display/DF120/Running+WSO2+Docker+Images)
