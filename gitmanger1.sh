#!/bin/bash

GREEN='\033[0;32m'  # Define the green color
NC='\033[0m'        # Define the no color (reset)

read -p "Enter git repo: " repo_url

# Repo clone destination
read -p "Enter the directory to clone the repository (or leave empty for the current directory): " repo_dir

# Set a default directory if none provided
if [ -z "$repo_dir" ]; then
    repo_dir="./"
fi

# Clone the Git repository
git clone "$repo_url" "$repo_dir"
cd "$repo_dir"

echo "What do you want to do today?"
while true; do
    echo -e "Git Repository Manager Menu"
    echo -e "1. ${GREEN}Create a new branch${NC}"
    echo -e "2. ${GREEN}Commit changes${NC}"
    echo -e "3. ${GREEN}Push changes${NC}"
    echo -e "4. ${GREEN}Pull changes from remote${NC}"
    echo -e "5. ${GREEN}Quit${NC}"

    read -p "Enter your choice (1/2/3/4/5):" choice
    case $choice in
        1)
            read -p "Enter the name for the new branch: " branch_name
            git checkout -b "$branch_name"
            ;;
        2)
            git status
            git add .
            read -p "Enter your commit message: " commit_message
            git commit -m "$commit_message"
            break
            ;;
        3)
            echo -e "Select push option:"
            echo -e "1. Push to current branch"
            echo -e "2. Push to a different branch"
            read -p "Enter your choice (1/2):" push_choice
            case $push_choice in
                1)
                    git push origin
                    ;;
                2)
                    read -p "Enter the name of the branch to push to: " push_branch
                    git push origin "$push_branch"
                    ;;
                *)
                    echo -e "${GREEN}Invalid push option.${NC}"
                    ;;
            esac
            ;;
        4)
            git pull origin
            break
            ;;
        5)
            echo "Exiting Git Repository Manager."
            break
            ;;
        *)
            echo -e "${GREEN}Invalid choice. Please enter a valid option (1/2/3/4/5).${NC}"
            ;;
    esac
done
