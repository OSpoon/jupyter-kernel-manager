#!/bin/bash

# Show menu and get user choice
echo -e "\n\033[36mJupyter Kernel Manager\033[0m"
echo -e "\033[32m1. Add new kernel\033[0m"
echo -e "\033[33m2. Remove existing kernel\033[0m"
echo -e "\033[31m3. Exit\033[0m"
read -p $'\nPlease enter your choice (1-3): ' choice

case $choice in
    1)
        # Add new kernel
        read -p "Please enter the environment name: " envName
        if [ -z "$envName" ]; then
            echo -e "\033[31mEnvironment name cannot be empty!\033[0m"
            exit 1
        fi

        read -p "Do you want to set a custom display name? (y/N): " useCustomDisplay
        if [[ $useCustomDisplay =~ ^[Yy]$ ]]; then
            read -p "Please enter the display name: " displayName
            if [ -z "$displayName" ]; then
                displayName=$envName
            fi
        else
            displayName=$envName
        fi

        # Check if conda is installed
        if ! command -v conda &> /dev/null; then
            echo -e "\033[31mError: conda command not found. Please ensure Anaconda or Miniconda is installed\033[0m"
            exit 1
        fi

        # Get list of all conda environments and create if not exists
        echo "Checking if environment '$envName' exists..."
        if ! conda env list | grep -q "^$envName "; then
            echo -e "\033[33mEnvironment '$envName' not found, creating...\033[0m"
            conda create -n "$envName" python ipykernel -y
            if [ $? -ne 0 ]; then
                echo -e "\033[31mFailed to create environment!\033[0m"
                exit 1
            fi
        fi

        # Install kernel
        echo -e "\033[32mAdding environment to Jupyter...\033[0m"
        conda run -n "$envName" python -m ipykernel install --user --name "$envName" --display-name "$displayName"

        if [ $? -eq 0 ]; then
            echo -e "\033[32mSuccessfully added environment '$envName' to Jupyter!\033[0m"
            echo -e "\033[32mDisplay name: '$displayName'\033[0m"
            echo -e "\n\033[36mTo see the new kernel, please restart Jupyter Lab:\033[0m"
            echo -e "\033[36m1. Close all Jupyter Lab windows\033[0m"
            echo -e "\033[36m2. Open terminal and run: jupyter lab\033[0m"
        else
            echo -e "\033[31mFailed to add environment to Jupyter!\033[0m"
        fi
        ;;
    2)
        # List available kernels
        echo -e "\n\033[36mAvailable kernels:\033[0m"
        jupyter kernelspec list

        echo -e "\n\033[32mRemovable kernels:\033[0m"
        jupyter kernelspec list | grep -v "deno\|python3$"

        if [ $? -ne 0 ]; then
            echo -e "\033[33mNo removable kernels found.\033[0m"
            exit 0
        fi

        read -p $'\nPlease enter the kernel name to remove (or press Enter to cancel): ' kernelToRemove
        if [ -z "$kernelToRemove" ]; then
            echo -e "\033[33mOperation cancelled.\033[0m"
            exit 0
        fi

        if [[ $kernelToRemove =~ ^(deno|python3)$ ]]; then
            echo -e "\033[31mCannot remove protected kernel '$kernelToRemove'!\033[0m"
            exit 1
        fi

        echo -e "\033[33mRemoving kernel '$kernelToRemove'...\033[0m"
        jupyter kernelspec remove "$kernelToRemove" -f

        if [ $? -eq 0 ]; then
            echo -e "\033[32mSuccessfully removed kernel '$kernelToRemove'!\033[0m"
            echo -e "\n\033[36mTo see the changes, please restart Jupyter Lab:\033[0m"
            echo -e "\033[36m1. Close all Jupyter Lab windows\033[0m"
            echo -e "\033[36m2. Open terminal and run: jupyter lab\033[0m"
        else
            echo -e "\033[31mFailed to remove kernel!\033[0m"
        fi
        ;;
    3)
        echo -e "\033[33mExiting...\033[0m"
        exit 0
        ;;
    *)
        echo -e "\033[31mInvalid choice!\033[0m"
        exit 1
        ;;
esac