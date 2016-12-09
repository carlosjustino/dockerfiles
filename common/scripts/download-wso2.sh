#!/bin/bash

REFERER=http://connect.wso2.com/wso2/getform/reg/new_product_download

if [ "$1" = "" ]; then
    echo "You must enter a (1)SHORTNAME and (2)VERSION parameter"
fi

if [ "$2" = "" ]; then
    echo "You must enter a (1)SHORTNAME and (2)VERSION parameter"
fi

SHORTNAME=$1
VERSION=$2

case $SHORTNAME in
    wso2esb )
        FULLNAME=enterprise-service-bus;;
    wso2am )
        FULLNAME=api-manager;;
    wso2bam )
        FULLNAME=business-activity-monitor;;
    wso2greg )
        FULLNAME=governance-registry;;
    wso2brs )
        FULLNAME=business-rules-server;;
    wso2dss )
        FULLNAME=data-services-server;;
    wso2cep )
        FULLNAME=complex-event-processor;;
    wso2cg )
        FULLNAME=cloud-gateway;;
    wso2mb )
        FULLNAME=message-broker;;
    wso2ss )
        FULLNAME=storage-server;;
    wso2ts )
        FULLNAME=task-server;;
    wso2elb )
        FULLNAME=elastic-load-balancer;;
    wso2bps )
        FULLNAME=business-process-server;;
    wso2emm )
        FULLNAME=enterprise-mobility-manager;;
    wso2store )
        FULLNAME=enterprise-store;;
    wso2is )
        FULLNAME=identity-server;;
    wso2ues )
        FULLNAME=user-engagement-server;;
    wso2as )
        FULLNAME=application-server;;
    wso2das )
        FULLNAME=data-analytics-server;;
    wso2es )
        FULLNAME=enterprise-store;;
esac

FILE="$SHORTNAME-$VERSION.zip"

if [ -f $FILE ];
then
   echo "$FILE already downloaded"
else
   wget --user-agent="testuser" --referer="$REFERER" "http://dist.wso2.org/products/$FULLNAME/$VERSION/$FILE"
fi
