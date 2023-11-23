export interface iRegisterPatient {
    nome: string;
    email: string;
    senha: string;
    cpf: string;
    dataNascimento: string;
    sexo: string;
    logradouro: string;
    numero: string;
    uf: string;
    cidade: string;
    bairro: string;
    cep: string;
    complemento: string;
}

export interface iRegisterDoctor {
    nome: string;
    email: string;
    senha: string;
    crm: string;
    especialidade: string;
    telefone: string;
    logradouro: string;
    numero: string;
    uf: string;
    cidade: string;
    bairro: string;
    cep: string;
    complemento: string;
}