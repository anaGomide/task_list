# Guia de Execução do Projeto Flutter

## Descrição do Projeto
Este é um aplicativo Flutter para gerenciar tarefas, permitindo criar, editar, excluir e visualizar tarefas em uma interface intuitiva.

---

## Requisitos

1. **Flutter SDK**:
   - Certifique-se de ter o Flutter instalado e configurado.
   - Para verificar a instalação, execute:
     ```bash
     flutter --version
     ```

2. **Versão do Flutter**:
   - Este projeto requer o Flutter **3.27.1** ou superior.
   - Atualize seu Flutter, se necessário:
     ```bash
     flutter upgrade
     ```

3. **Dependências Adicionais**:
   - Certifique-se de ter o **Dart SDK** e um editor como **VS Code** ou **Android Studio** configurados.

4. **Plataformas Suportadas**:
   - Android
   - iOS
   - Web

---

## Passos para Executar o Projeto

### 1. Clone o Repositório
Use o Git para clonar o projeto no seu computador:
```bash
git clone https://github.com/anaGomide/task_list.git
```
### 2.  Instale as Dependências
No diretório do projeto, instale todas as dependências necessárias:
```bash
flutter pub get
```
### 3. Configure o Firebase (se necessário)
O projeto utiliza Firebase, configure o arquivo google-services.json (Android) ou GoogleService-Info.plist (iOS):
    Baixe os arquivos do console do Firebase.
    Coloque os arquivos nas pastas correspondentes:
    android/app/google-services.json
    ios/Runner/GoogleService-Info.plist

### 4. Conecte um Dispositivo ou Emulador
Certifique-se de que um dispositivo ou emulador esteja conectado e configurado:

  Para listar dispositivos conectados:
  ```bash
  flutter devices
  ```

### 5. Execute o Projeto
Para rodar o projeto, use o seguinte comando:
 ```bash
  flutter run
  ```

## Solução de Problemas:
### Problema com Dependências:
``` bash
flutter pub get
flutter clean
flutter pub get
```

### Erro de Compatibilidade com o Flutter SDK:
Certifique-se de usar a versão correta do Flutter especificada no arquivo pubspec.yaml.

### Erro com Firebase:
Verifique se o arquivo google-services.json (Android) ou GoogleService-Info.plist (iOS) está configurado corretamente.

## Estrutura do Projeto
- **`lib/`**: Contém o código principal do aplicativo.
  - **`models/`**: Modelos de dados do aplicativo.
  - **`viewmodels/`**: Lógica de negócios (MVVM).
  - **`widgets/`**: Widgets reutilizáveis.
  - **`screens/`**: Telas principais do aplicativo.

- **`assets/`**: Contém imagens, ícones e outros arquivos estáticos.
