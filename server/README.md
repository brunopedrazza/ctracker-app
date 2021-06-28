[![Build status](https://dev.azure.com/pedrazzabruno/ctracker/_apis/build/status/ctracker)](https://dev.azure.com/pedrazzabruno/ctracker/_build/latest?definitionId=2)

# Backend

&emsp;O _backend_ do projeto está escrito em Python, com o framework Django. A responsabilidade desse componente é de expor diversos endpoints por meio de uma API privada, além de executar algumas tarefas que precisam ser realizadas de tempos em tempos. Os dados estão sendo armazenados em um banco não-relacional PostgreSQL, escolhido pelo motivo de melhor compatibilidade com o _framework_.

&emsp;Toda a lógica de negócio do aplicativo está implementada neste componente, fazendo com que a única responsabilidade da aplicação em _Flutter_ seja a de oferecer uma interface amigável e fluida para a interação dos usuários do aplicativo com os dados em si.

&emsp;Todas as funcionalidades do _backend_ rodam em _containers_ no Docker dedicados separadamente, mas a aplicação por completo utiliza um orquestrador de _containers_ para juntar todas essas partes.

&emsp;O código fonte do _backend_ se encontra no diretório _/server_ localizado na raiz do projeto.

&emsp;

## **_API_**

&emsp;A API tem como objetivo estabelecer a comunicação entre o frontend e os dados que estão armazenados no servidor. Os endpoints estão seguros por uma única API-KEY, que somente a aplicação _frontend_ tem posse, pelo menos por enquanto.

&emsp;Código fonte localizado no diretório _/server/ctracker/api._


## Autenticação

&emsp;Todas as requisições devem incluir a **API-KEY** no _header_ para serem aceitas, da seguinte forma:


```curl
curl --location --request POST 'http://localhost:8000/api/place/register' \
--header 'X-API-KEY: fakeapikey1234' \
--header 'Content-Type: application/json'
```

&emsp;

## Erros

São utilizados os códigos de resposta no padrão _HTTP_ para indicar o sucesso ou falha de uma requisição. Códigos no range _2xx_ indicam sucesso, enquanto códigos no range _4xx_ indicam falha na requisição. Códigos no rage _5xx_ indicam uma falha no servidor da aplicação.


<table>
  <tr>
   <td>200 - OK
   </td>
   <td>Tudo ocorreu como esperado
   </td>
  </tr>
  <tr>
   <td>201 - Created
   </td>
   <td>Indica que o novo recurso foi criado com sucesso
   </td>
  </tr>
  <tr>
   <td>400 - Bad Request
   </td>
   <td>Algum erro do cliente, possivelmente um parâmetro faltando ou incorreto
   </td>
  </tr>
  <tr>
   <td>401 - Unauthorized
   </td>
   <td>API-KEY inválida ou não informada
   </td>
  </tr>
  <tr>
   <td>404 - Not Found
   </td>
   <td>O recurso requisitado não foi encontrado, provavelmente não existe
   </td>
  </tr>
  <tr>
   <td>500 - Internal Server Error
   </td>
   <td>Problema interno no servidor
   </td>
  </tr>
</table>
&emsp;

Todas as requisições que falharem irão vir retornadas com uma descrição mais detalhada do motivo do problema no corpo da resposta, se possível. Exemplo:


```json
{
    "error": "user nas notifications disabled"
}
```

&emsp;

## **Endpoints**


## Users

&emsp;Endpoints que lidam com os dados dos usuários do aplicativo. Possui as funcionalidades de registrar um novo usuário, atualizar um existente, consultar os dados de um usuário e realizar o seu login.

&emsp;

## 1. Registro de um novo usuário
&emsp;

&emsp;&emsp;**_POST_** /api/user/register

### Request body

*   <font size="4">first_name</font> _string_
    *   primeiro nome do usuário
*   <font size="4">last_name</font> _string_
    *   último nome do usuário
*   <font size="4">email</font> _string_
    *   email do usuário, será usado para o login no aplicativo
*   <font size="4">birthdate</font> _string_
    *   data de nascimento do usuário
*   <font size="4">password</font> 	_string_
    *   senha do usuário criptografada no formato SHA-512 

```json
{
    "first_name": "Matheus",
    "last_name": "Scolari",
    "email": "exemplo@gmail.com",
    "birthdate": "31/05/1995",
    "password": "senha criptografada"
}
```
&emsp;

## 2. Atualização de um usuário existente

&emsp;Irá sobrescrever os dados já existentes para esse usuário.
&emsp;
&emsp;

&emsp;&emsp;**_POST_** /api/user/update/_:email_

### Request body


*   <font size="4">first_name</font> _string_
    *   primeiro nome do usuário atualizado
*   <font size="4">last_name</font> _string_
    *   último nome do usuário atualizado
*   <font size="4">birthdate</font> _string_
    *   data de nascimento do usuário atualizado

```json
{
    "first_name": "Matheus",
    "last_name": "Moreira",
    "birthdate": "31/05/1995",
}
```

&emsp;

## 3. Consulta a um usuário
&emsp;

&emsp;&emsp;**_GET_** /api/user/_:email_

### Response body

*   <font size="4">first_name</font> _string_
    *   primeiro nome do usuário
*   <font size="4">last_name</font> _string_
    *   último nome do usuário
*   <font size="4">email</font> _string_
    *   email do usuário
*   <font size="4">birthdate</font> _string_
    *   data de nascimento do usuário
*   <font size="4">notification_enabled</font>	_boolean_
    *   indica se o usuário está habilitado a notificar que está infectado pelo vírus

```json
{
    "first_name": "Matheus",
    "last_name": "Moreira",
    "birthdate": "31/05/1995",
    "email": "exemplo@gmail.com",
    "notification_enabled": true
}
```

&emsp;
## 4. Login de um usuário
&emsp;

&emsp;&emsp;**_POST_** /api/user/login

### Request body


*   <font size="4">email</font> _string_
    *   email do usuário
*   <font size="4">password</font>  _string_
    *   senha do usuário

```json
{
    "email": "exemplo@gmail.com",
    "password": "senha criptografada"
}
```


&emsp;Caso a senha esteja incorreta, é retornado _400 - Bad Request_.

&emsp;Se a senha está correta, retorna _200 - OK_, junto com as informações do usuário no corpo da resposta.
&emsp;


### Response body


*   <font size="4">first_name</font> _string_
    *   primeiro nome do usuário logado
*   <font size="4">last_name</font> _string_
    *   último nome do usuário logado
*   <font size="4">email</font> _string_
    *   email do usuário logado
*   <font size="4">birthdate</font> _string_
    *   data de nascimento do usuário logado
*   <font size="4">notification_enabled</font>	_boolean_
    *   indica se o usuário logado está habilitado a notificar que está infectado pelo vírus

```json
{
    "first_name": "Matheus",
    "last_name": "Moreira",
    "birthdate": "31/05/1995",
    "email": "exemplo@gmail.com",
    "notification_enabled": true
}
```
&emsp;



## Places

&emsp;Endpoints relacionados com o registro dos lugares que cada usuário visitou e indicou no aplicativo. Possui as funcionalidades de registrar a ida de um usuário a um certo lugar no período indicado, e também de listar todos os lugares que um usuário registrou presença.



## 1. Indicar que usuário visitou um lugar específico
&emsp;

&emsp;&emsp;**_POST_** /api/place/register

### Request body


*   <font size="4">user_email</font> _string_
    *   email do usuário que registrou ida ao estabelecimento
*   <font size="4">arrival_date</font>	_string_
    *   data e hora de chegada ao lugar visitado no formato dd/mm/yyyy HH:MM
*   <font size="4">departure_date</font> _string_
    *   data e hora de saída do lugar visitado no formato dd/mm/yyyy HH:MM
*   <font size="4">place_id</font> _string_
    *   identificador único do lugar visitado na API do Google Maps

```json
{
    "user_email": "exemplo@gmail.com",
    "arrival_date": "21/04/2021 18:00",
    "departure_date": "21/04/2021 19:30",
    "place_id": "ChIJgUbEo8cfqokR5lP9_Wh_DaM"
}
```
&emsp;

## 2. Listagem dos lugares que usuário visitou e registrou
&emsp;

&emsp;&emsp;**_GET_** /api/place/user/_:email_

### Response body



*   <font size="4">arrival_date</font>	_string_
    *   data e hora de chegada ao lugar visitado no formato dd/mm/yyyy HH:MM
*   <font size="4">departure_date</font> _string_
    *   data e hora de saída do lugar visitado no formato dd/mm/yyyy HH:MM
*   <font size="4">place_id</font>	_string_
    *   identificador único do lugar visitado na API do Google Maps
*   <font size="4">number_of_notifications</font> _integer_
    *   indica o número de pessoas que notificaram que estavam infectadas e estavam presentes no mesmo dia, horário e local especificados neste registro em uma janela de tempo pré-estabelecida antes da notificação do usuário infectado acontecer

```json
[
    {
        "arrival_date": "21/04/2021 18:00",
        "departure_date": "21/04/2021 19:30",
        "place_id": "ChIJgUbEo8cfqokR5lP9_Wh_DaM",
        "number_of_notifications": 0
    },
    {
        "arrival_date": "23/04/2021 13:00",
        "departure_date": "23/04/2021 13:30",
        "place_id": "GhIJQWDl0CIeQUARxks3icF8U8A",
        "number_of_notifications": 2
    },
    {
        "arrival_date": "29/04/2021 21:00",
        "departure_date": "29/04/2021 21:10",
        "place_id": "ChIJgUbEo8cfqokR5lP9_Wh_DaM",
        "number_of_notifications": 0
    }
]
```



&emsp;Nesse exemplo, podemos observar que o usuário já registrou 3 vezes no aplicativo que visitou algum lugar. Dois desses registros foram uma visita a um mesmo estabelecimento em dias e horários diferentes e nenhum outro usuário que notificou que estava infectado pelo vírus frequentou esse mesmo lugar nesses horários. 

&emsp;Em contrapartida, em um dos seus registros de visita a um local, 2 outros usuários que notificaram alguns dias depois estar infectados pelo vírus estavam nesse local na mesma hora desse usuário. Nesse ponto, esse usuário deve ficar atento.

&emsp;
## Notifications

&emsp;Possui apenas um endpoint. Ao chamá-lo, o usuário notifica para o servidor que, obrigatoriamente, realizou o teste e o resultado deu positivo para a presença do vírus em questão. A data do teste precisa ser próxima a data da notificação, de preferência imediatamente após tomar o conhecimento da infecção.

&emsp;Um usuário que realiza essa notificação fica desabilitado a enviar novas notificações por um período pré-determinado, visto o tempo que os órgãos de saúde indicam que há possibilidade de reinfecção.

&emsp;

## 1. Notifica que usuário está infectado
&emsp;

&emsp;&emsp;**_POST_** /api/notification

### Request body



*   <font size="4">user_email</font> _string_
    *   email do usuário que enviou a notificação
*   <font size="4">symptoms</font>	_string_
    *   sintomas que o usuário está sentindo

```json
{
    "user_email": "exemplo@gmail.com",
    "symptoms": "Dor de cabeça, tontura"
}
```


&emsp;

## **_Time-trigger events_**

&emsp;É o momento em que toda a lógica de negócio do servidor acontece.

&emsp;São comandos executados de tempos em tempos que realizam certas consultas ao banco e atualizam o seu estado se necessário, mantendo os dados consistentes e em sincronia com a forma com que o aplicativo precisa se comportar.

&emsp;Código fonte localizado no diretório _server/ctracker/management/commands._

&emsp;

## Procura por usuários com notificação desabilitada

&emsp;É feita uma consulta por todos os usuários que estão com a notificação desabilitada, ou seja, que notificaram que estão infectadas recentemente. Para cada usuário, é verificada qual a última notificação registrada para ele. Se essa notificação já foi feita a uma quantidade pré-determinada de dias atrás, a notificação para esse usuário volta a ficar habilitada.

&emsp;De acordo com pesquisas sobre o tempo de reinfecção pelo vírus, foi definido um período mínimo de 20 dias entre uma notificação e outra.

&emsp;

### Code snippet
```python
now = utc_now()
x_days_ago = now - timedelta(days=server_settings.DAYS_TO_LIMIT_NOTIFICATION)

users_notification_disabled = User.objects.exclude(notification_enabled=True).all()
for user in users_notification_disabled:
    try:
        SicknessNotification.objects.get(user=user, created_at__gte=x_days_ago)
    except ObjectDoesNotExist:
        logger.info(f"Enabling notification from user {user}")
        user.notification_enabled = True
        user.save()
```
&emsp;

## Procura por notificações não processadas

&emsp;Assim que uma notificação é criada, ela é vista como não processada para o sistema.

&emsp;Uma consulta é feita por aquelas notificações que ainda não foram processadas. Para cada notificação, vimos quais lugares o usuário que realizou essa notificação indicou que frequentou nos últimos 5 dias, período em que ele potencialmente possa ter infectado alguém pelos lugares em que frequentou. Para cada lugar, é verificado se alguma pessoa registrou que também esteve presente no mesmo lugar simultaneamente com o usuário infectado. Essa notificação passa a ser vista como processada para o sistema.

&emsp;Com isso em mãos, podemos avisar de alguma forma para cada usuário que satisfaz essas condições que ela potencialmente teve contato com uma pessoa infectada, e, ainda mais precisamente, em qual local que isso aconteceu.

&emsp;

### Code snippet
```python
unprocessed_notifications: List[SicknessNotification] = (
            SicknessNotification.objects
            .select_related("user")
            .filter(is_processed=False)
            .order_by("created_at")
            .all()
        )

for notification in unprocessed_notifications:
    logger.debug(f"Processing notification {notification}")
    x_days_ago = notification.created_at - timedelta(days=server_settings.DAYS_BEFORE_NOTIFICATION)
    places_user_has_been = UserPlaceRegister.objects.filter(
        user=notification.user,
        departure_date__gt=x_days_ago
    ).all()

    for place_user_has_been in places_user_has_been:
        before_time_window_qparams = Q(
            departure_date__lt=place_user_has_been.arrival_date
        )
        after_time_window_qparams = Q(
            arrival_date__gt=place_user_has_been.departure_date
        )
        registers_to_notify: List[UserPlaceRegister] = (
            UserPlaceRegister.objects
            .filter(place_id=place_user_has_been.place_id)
            .exclude(
                before_time_window_qparams |
                after_time_window_qparams |
                Q(user=notification.user) |
                Q(has_to_notify=True)
            )
            .all()
        )
        for register in registers_to_notify:
            logger.debug(f"Indicate that {register} needs to be notified")
            register.number_of_notifications += 1
            register.has_to_notify = True
            register.save()

    logger.debug(f"Notification {notification} was processed")
    notification.is_processed = True
    notification.save()
```
&emsp;
## Próximos passos



*   Definir se vamos utilizar cadastro e login do usuário por meio de serviços externos (Google, Facebook, etc) ou se vamos manter os usuários e senhas em nossa própria base de dados.
*   Definir se é preciso realmente enviar uma notificação _push _para o usuário quando reconhecemos um potencial contato com uma pessoa infectada ou se vamos apenas indicar isso de forma visual ao abrir o aplicativo.
*   Definir em qual serviço externo iremos utilizar para servir a nossa base de dados e a aplicação backend.
*   Testar todos os fluxos com um volume de dados maior e com mais requisições simultâneas.
