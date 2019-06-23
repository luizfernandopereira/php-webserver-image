<?php if (version_compare(phpversion(), '7.1.17', '>')):?>
<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>O servidor está funcionando corretamente</title>

        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:400,700" rel="stylesheet"> 

        <style>
            * {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
            }

            body {
                padding: 0;
                margin: 0;
            }

            #success {
                position: relative;
                height: 100vh;
                background-color: #222;
            }

            #success .success {
                position: absolute;
                left: 50%;
                top: 50%;
                -webkit-transform: translate(-50%, -50%);
                    -ms-transform: translate(-50%, -50%);
                        transform: translate(-50%, -50%);
            }

            .success {
                max-width: 460px;
                width: 100%;
                text-align: center;
                line-height: 1.4;
            }

            .success .title {
                height: 158px;
                line-height: 153px;
            }

            .success .title h1 {
                font-family: 'Josefin Sans', sans-serif;
                color: #222;
                font-size: 220px;
                letter-spacing: 10px;
                margin: 0px;
                font-weight: 700;
                text-shadow: 2px 2px 0px #c9c9c9, -2px -2px 0px #c9c9c9;
            }

            .success .title h1>span {
                text-shadow: 2px 2px 0px #48ff00, -2px -2px 0px #48ff00, 0px 0px 8px #48ff00;
            }

            .success p {
                font-family: 'Josefin Sans', sans-serif;
                color: #c9c9c9;
                font-size: 16px;
                font-weight: 400;
                margin-top: 0px;
                margin-bottom: 15px;
            }

            .success a {
                font-family: 'Josefin Sans', sans-serif;
                font-size: 14px;
                text-decoration: none;
                text-transform: uppercase;
                background: transparent;
                color: #c9c9c9;
                border: 2px solid #c9c9c9;
                display: inline-block;
                padding: 10px 25px;
                font-weight: 700;
                -webkit-transition: 0.2s all;
                transition: 0.2s all;
            }

            .success a:hover {
                color: #ffab00;
                border-color: #ffab00;
            }

            @media only screen and (max-width: 480px) {
                .success .title {
                    height: 122px;
                    line-height: 122px;
                }

                .success .title h1 {
                    font-size: 122px;
                }
            }
        </style>

    </head>
    <body>
        <div id="success">
            <div class="success">
                <div class="title">
                    <h1><span>Ok!</span></h1>
                </div>
                <p>
                    Esta página indica que o servidor está funcionando corretamente.
                </p>
            </div>
        </div>
    </body>
</html>
<?php else: ?>
    <?php http_response_code(500)?>
<?php endif; ?>