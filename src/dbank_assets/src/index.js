import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function(){
    // console.log("This part is working properly");
    update();
});

document.querySelector("form").addEventListener("submit", async function(){
    event.preventDefault(); // prevents the form from going back to its original empty state
    console.log("submitted.");
    
    const button = event.target.querySelector("#submit-btn");

    const inputAmount = parseFloat(document.getElementById("input-amount").value);
    const withdrawAmount = parseFloat(document.getElementById("withdrawal-amount").value);

    // the submit button is disableed when an amount is inputted and submit button is clicked
    button.setAttribute("disabled",true);

    if (document.getElementById("input-amount").value.length !=0){
        await dbank.topUp(inputAmount);
    }

    
    if(document.getElementById("withdrawal-amount").value.length !=0){
        await dbank.withdraw(withdrawAmount);
    }

    await dbank.Compound();

    update();

    document.getElementById("input-amount").value= "";
    document.getElementById("withdrawal-amount").value= "";

    // once the topUp value is added the checkBalance value is displayed with the updated value, the submit button is enabled again
    button.removeAttribute("disabled");
});

async function update(){
    const currentAmount = await dbank.checkBalance();
    document.getElementById("value").innerText = Math.round(currentAmount * 100)/100;
}