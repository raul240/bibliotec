document.getElementById("cadastro-form").addEventListener("submit", async (e) => {
    e.preventDefault();

    const nome = document.getElementById("nome").value;
    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    const response = await fetch("http://localhost:3000/cadastro", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ nome, email, senha }) 
    });

    const data = await response.json();

    if (response.ok) {
        alert("Conta criada com sucesso!");
        window.location.href = "../index.html"; 
    } else {
        alert(data.erro);
    }
      
});
