#!/usr/bin/env bash

DATAMODEL_WRAPPER="Resources/database.xcdatamodeld"
DATAMODEL_CURRENT=`/usr/libexec/PlistBuddy -c "print _XCCurrentVersionName" "$DATAMODEL_WRAPPER"/.xccurrentversion`
DATAMODEL_PATH="$DATAMODEL_WRAPPER/$DATAMODEL_CURRENT"

mogenerator -model $DATAMODEL_PATH -o Source/Main/Models/
