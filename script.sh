#!/bin/bash

# Replace with your Jira URL, username, and password/token
JIRA_URL="https://manish4demo.atlassian.net"
USERNAME="kmanishkundanbhai@deloitte.com"
API_TOKEN="$JIRA_TOKEN"


echo "API TOKEN :: " $API_TOKEN


# Replace with the issue key
ISSUE_KEY="DEMO-1"

# Replace with the filename you're looking for
FILENAME_TO_FIND="TestData.xlsx"

ISSUE_URL="$JIRA_URL/rest/api/3/issue/$ISSUE_KEY?fields=attachment"
ISSUE_DATA=$(curl -u "$USERNAME:$API_TOKEN" -X GET -H "Content-Type: application/json" "$ISSUE_URL")

echo "ISSUE URL :: " $ISSUE_URL
echo ""
echo ""
echo "ISSUE DATA ::" $ISSUE_DATA
echo ""
echo ""
echo ""
# Check if the issue exists
#if [[ "$ISSUE_DATA" == *"Issue does not exist"* ]]; then
#    echo "Issue $ISSUE_KEY not found."
#    exit 1
#fi

# Step 3: Search for the attachment by filename
ATTACHMENT_ID=$(echo "$ISSUE_DATA" | jq -r ".fields.attachment[] | select(.filename == \"$FILENAME_TO_FIND\") | .id")

echo "Fetching Attachment using ID"

curl -L -O --request GET \
            --url "$JIRA_URL/rest/api/3/attachment/content/$ATTACHMENT_ID" \
            --user "$USERNAME:$API_TOKEN" 

#sudo cp "$ATTACHMENT_ID" "$FILENAME_TO_FIND" 
sudo mv -f "$ATTACHMENT_ID" "$FILENAME_TO_FIND" 
