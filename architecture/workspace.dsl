workspace "WoodRoute" "Plataforma web SaaS para la gestión y seguimiento de fabricación de muebles personalizados." {

    !identifiers hierarchical

    model {

        // ─────────────────────────────────────────────
        // Actores (Persons)
        // ─────────────────────────────────────────────
        // El "Visitante" identificado en 2.4 Big Picture EventStorming se modela
        // aquí como el estado pre-autenticado del Cliente o Carpintero durante
        // el onboarding, no como un actor independiente.

        cliente = person "Cliente" "Solicita muebles personalizados, acepta cotizaciones, realiza pagos y consulta el estado de su pedido."

        carpintero = person "Carpintero / Taller" "Gestiona pedidos, materiales, producción e inventario; emite cotizaciones y órdenes de compra a proveedores."

        // ─────────────────────────────────────────────
        // Sistema bajo diseño
        // ─────────────────────────────────────────────
        // Arquitectura: monolito modular .NET 10 organizado por bounded contexts
        // (DDD). Cada bounded context se modela como un container lógico de
        // Structurizr con su propia estructura interna:
        //   Controller (.NET 10) → Service → Repository (EF Core) → Aggregate
        // Los cinco bounded contexts se agrupan visualmente bajo "API
        // Application" para reflejar que comparten el mismo despliegue.
        //
        // Decisiones de tecnología (a formalizar en sección 5.1 - SCM):
        //   - Frontend SPA con Vue 3 + Vite
        //   - Backend monolítico con .NET 10
        //   - Base de datos relacional PostgreSQL

        woodroute = softwareSystem "WoodRoute" "Plataforma web SaaS para la gestión y seguimiento de fabricación de muebles personalizados." {

            webApp = container "Web Application" "Aplicación SPA responsiva que provee la interfaz a clientes y carpinteros, consumiendo el Backend API." "Vue 3 + Vite" {

                appShell = component "App Shell / Layout" "Estructura visual base de la SPA: navbar, sidebar, footer y layout responsivo." "Vue 3"
                router = component "Router" "Rutas de la SPA y guards de autenticación antes de montar las vistas protegidas." "Vue Router"
                authStore = component "Auth Store" "Estado de sesión, tokens JWT y refresh; expone el usuario autenticado." "Pinia"
                domainStores = component "Domain Stores" "Stores de estado del lado cliente por bounded context: pedidos, inventario, producción y mensajería." "Pinia"
                apiClient = component "API Client" "Cliente HTTP con interceptores que adjuntan el token de sesión; consume el Backend API." "Axios"

                onboardingViews = component "Onboarding Views" "Landing pública, registro, login, recuperación de contraseña y gestión de perfil." "Vue 3"
                inventarioViews = component "Inventario Views" "Listado de materiales, alertas de stock bajo y gestión del inventario." "Vue 3"
                ventasViews = component "Cotización y Venta Views" "Formulario de pedido, visualización de cotizaciones, aceptación/rechazo y checkout de pagos." "Vue 3"
                produccionViews = component "Producción Views" "Tablero de producción por etapas, registro de avances y consumo de materiales." "Vue 3"
                seguimientoViews = component "Seguimiento y Comunicación Views" "Mensajería con el cliente, encuestas post-entrega y reseñas." "Vue 3"
            }

            group "API Application" {

                onboardingContext = container "Onboarding Context" "Registro, login, recuperación de contraseña y gestión de perfil." ".NET 10 Module" {
                    tags "BoundedContext"

                    onboardingController = component "AuthController" "Expone endpoints REST de registro, login, recuperación de contraseña y perfil." ".NET 10 Web API"
                    onboardingService    = component "AuthService"    "Lógica de autenticación, emisión y validación de JWT, autorización por rol." ".NET 10 Identity"
                    onboardingRepository = component "UserRepository" "Acceso a datos de usuarios y perfiles." "Entity Framework Core"
                    onboardingAggregate  = component "User"           "Aggregate root del bounded context: usuario con credenciales y perfil." "EF Core Entity" {
                        tags "Aggregate"
                    }
                }

                inventarioContext = container "Inventario Context" "Gestión de materiales, control de stock y órdenes de compra al proveedor." ".NET 10 Module" {
                    tags "BoundedContext"

                    inventarioController = component "MaterialController" "Expone endpoints REST de materiales, stock y órdenes de compra." ".NET 10 Web API"
                    inventarioService    = component "MaterialService"    "Lógica de inventario: CRUD, control de mínimos y generación de OC al proveedor (HU44)." ".NET 10"
                    inventarioRepository = component "MaterialRepository" "Acceso a datos de materiales, stock y órdenes de compra." "Entity Framework Core"
                    inventarioAggregate  = component "Material"           "Aggregate root del bounded context: material con stock, mínimo configurado e imágenes." "EF Core Entity" {
                        tags "Aggregate"
                    }
                }

                ventasContext = container "Cotización y Venta Context" "Pedidos, cotizaciones, aceptación de presupuestos y procesamiento de pagos." ".NET 10 Module" {
                    tags "BoundedContext"

                    ventasController     = component "OrderController" "Expone endpoints REST de pedidos, cotizaciones y pagos." ".NET 10 Web API"
                    ventasService        = component "OrderService"    "Lógica de pedidos, cálculo de presupuestos y aceptación/rechazo." ".NET 10"
                    ventasPaymentService = component "PaymentService"  "Procesamiento de anticipos y saldos finales contra la pasarela." ".NET 10 + HttpClient"
                    ventasRepository     = component "OrderRepository" "Acceso a datos de pedidos, cotizaciones y pagos." "Entity Framework Core"
                    ventasAggregate      = component "Order"           "Aggregate root del bounded context: pedido con su cotización y pagos asociados." "EF Core Entity" {
                        tags "Aggregate"
                    }
                }

                produccionContext = container "Producción Context" "Etapas de fabricación, consumo de materiales y entrega del mueble." ".NET 10 Module" {
                    tags "BoundedContext"

                    produccionController = component "ProductionController" "Expone endpoints REST de producción y avance." ".NET 10 Web API"
                    produccionService    = component "ProductionService"    "Lógica de producción: planificación de etapas, registro de avance y consumo de materiales." ".NET 10"
                    produccionRepository = component "ProductionRepository" "Acceso a datos de etapas y consumo de materiales." "Entity Framework Core"
                    produccionAggregate  = component "ManufactureOrder"     "Aggregate root del bounded context: orden de fabricación con sus etapas y materiales consumidos." "EF Core Entity" {
                        tags "Aggregate"
                    }
                }

                seguimientoContext = container "Seguimiento y Comunicación Context" "Mensajería con el cliente, encuestas post-entrega, reseñas y envío de notificaciones." ".NET 10 Module" {
                    tags "BoundedContext"

                    seguimientoController          = component "MessageController"     "Expone endpoints REST de mensajería, encuestas y reseñas." ".NET 10 Web API"
                    seguimientoMessageService      = component "MessageService"        "Lógica de mensajería e historial del pedido." ".NET 10"
                    seguimientoNotificationService = component "NotificationService"   "Orquesta el envío de notificaciones (correo, push, WhatsApp) integrando el proveedor externo." ".NET 10 + SDK"
                    seguimientoReviewService       = component "ReviewService"         "Lógica de encuestas post-entrega y reseñas." ".NET 10"
                    seguimientoRepository          = component "MessageRepository"     "Acceso a datos de mensajes, encuestas y reseñas." "Entity Framework Core"
                    seguimientoAggregate           = component "Conversation"          "Aggregate root del bounded context: conversación con el cliente y sus reseñas asociadas." "EF Core Entity" {
                        tags "Aggregate"
                    }
                }
            }

            db = container "Database" "Almacena usuarios, pedidos, cotizaciones, inventario, eventos de producción y reseñas." "PostgreSQL" {
                tags "Database"
            }
        }

        // ─────────────────────────────────────────────
        // Sistemas externos
        // ─────────────────────────────────────────────

        pasarelaPagos = softwareSystem "Pasarela de pagos" "Procesa anticipos y saldos finales de los pedidos del cliente." {
            tags "External" "Simulated"
        }

        notificaciones = softwareSystem "Servicio de notificaciones" "Proveedor externo de canales de notificación: correo, push, in-app y mensajería vía WhatsApp Business API." {
            tags "External" "Simulated"
        }

        proveedorMadera = softwareSystem "Proveedor de madera" "Recibe órdenes de compra automáticas cuando el stock de un material cae por debajo del mínimo (HU44)." {
            tags "External" "Simulated"
        }

        cloudStorage = softwareSystem "Cloud Storage" "Almacena imágenes de materiales del inventario y fotos del avance de fabricación." {
            tags "External" "Simulated"
        }

        // ─────────────────────────────────────────────
        // Relaciones — Actores ↔ Web Application
        // ─────────────────────────────────────────────

        cliente -> woodroute.webApp "Consulta cotizaciones, acepta presupuestos, realiza pagos y consulta el estado de los pedidos" "HTTPS"
        carpintero -> woodroute.webApp "Gestiona pedidos, cotizaciones, materiales, producción e inventario" "HTTPS"

        // Notificaciones externas → actores
        notificaciones -> cliente "Entrega correos, push y mensajes con avances del pedido, recordatorios y reseñas"
        notificaciones -> carpintero "Entrega correos, push y mensajes con nuevos pedidos, alertas de stock y respuestas del cliente"

        // ─────────────────────────────────────────────
        // Relaciones internas — Web Application
        // ─────────────────────────────────────────────

        woodroute.webApp.appShell -> woodroute.webApp.router "Monta las vistas activas"
        woodroute.webApp.router -> woodroute.webApp.authStore "Verifica sesión antes de navegar a vistas protegidas"
        woodroute.webApp.router -> woodroute.webApp.onboardingViews "Rutea a"
        woodroute.webApp.router -> woodroute.webApp.inventarioViews "Rutea a"
        woodroute.webApp.router -> woodroute.webApp.ventasViews "Rutea a"
        woodroute.webApp.router -> woodroute.webApp.produccionViews "Rutea a"
        woodroute.webApp.router -> woodroute.webApp.seguimientoViews "Rutea a"

        woodroute.webApp.onboardingViews -> woodroute.webApp.apiClient "Llama"
        woodroute.webApp.inventarioViews -> woodroute.webApp.apiClient "Llama"
        woodroute.webApp.ventasViews -> woodroute.webApp.apiClient "Llama"
        woodroute.webApp.produccionViews -> woodroute.webApp.apiClient "Llama"
        woodroute.webApp.seguimientoViews -> woodroute.webApp.apiClient "Llama"

        woodroute.webApp.onboardingViews -> woodroute.webApp.domainStores "Lee/escribe estado"
        woodroute.webApp.inventarioViews -> woodroute.webApp.domainStores "Lee/escribe estado"
        woodroute.webApp.ventasViews -> woodroute.webApp.domainStores "Lee/escribe estado"
        woodroute.webApp.produccionViews -> woodroute.webApp.domainStores "Lee/escribe estado"
        woodroute.webApp.seguimientoViews -> woodroute.webApp.domainStores "Lee/escribe estado"

        woodroute.webApp.apiClient -> woodroute.webApp.authStore "Adjunta token JWT a las peticiones"

        // Web App → Controladores REST de cada bounded context
        woodroute.webApp.apiClient -> woodroute.onboardingContext.onboardingController "Consume endpoints de auth" "HTTPS / JSON"
        woodroute.webApp.apiClient -> woodroute.inventarioContext.inventarioController "Consume endpoints de inventario" "HTTPS / JSON"
        woodroute.webApp.apiClient -> woodroute.ventasContext.ventasController "Consume endpoints de pedidos y pagos" "HTTPS / JSON"
        woodroute.webApp.apiClient -> woodroute.produccionContext.produccionController "Consume endpoints de producción" "HTTPS / JSON"
        woodroute.webApp.apiClient -> woodroute.seguimientoContext.seguimientoController "Consume endpoints de mensajería" "HTTPS / JSON"

        // ─────────────────────────────────────────────
        // Onboarding Context — flujo interno
        // ─────────────────────────────────────────────

        woodroute.onboardingContext.onboardingController -> woodroute.onboardingContext.onboardingService "Orquesta lógica de autenticación"
        woodroute.onboardingContext.onboardingService -> woodroute.onboardingContext.onboardingRepository "Usa repositorio"
        woodroute.onboardingContext.onboardingRepository -> woodroute.onboardingContext.onboardingAggregate "Gestiona Aggregate"
        woodroute.onboardingContext.onboardingRepository -> woodroute.db "Lee y escribe usuarios y perfiles" "EF Core"

        // ─────────────────────────────────────────────
        // Inventario Context — flujo interno y externo
        // ─────────────────────────────────────────────

        woodroute.inventarioContext.inventarioController -> woodroute.inventarioContext.inventarioService "Orquesta lógica de inventario"
        woodroute.inventarioContext.inventarioService -> woodroute.inventarioContext.inventarioRepository "Usa repositorio"
        woodroute.inventarioContext.inventarioRepository -> woodroute.inventarioContext.inventarioAggregate "Gestiona Aggregate"
        woodroute.inventarioContext.inventarioRepository -> woodroute.db "Lee y escribe materiales, stock y órdenes de compra" "EF Core"

        woodroute.inventarioContext.inventarioService -> proveedorMadera "Genera orden de compra cuando el stock está bajo" "HTTPS"
        woodroute.inventarioContext.inventarioService -> cloudStorage "Sube imágenes de materiales" "HTTPS"

        // ─────────────────────────────────────────────
        // Cotización y Venta Context — flujo interno y externo
        // ─────────────────────────────────────────────

        woodroute.ventasContext.ventasController -> woodroute.ventasContext.ventasService "Orquesta lógica de pedidos y cotizaciones"
        woodroute.ventasContext.ventasController -> woodroute.ventasContext.ventasPaymentService "Orquesta procesamiento de pagos"
        woodroute.ventasContext.ventasService -> woodroute.ventasContext.ventasRepository "Usa repositorio"
        woodroute.ventasContext.ventasPaymentService -> woodroute.ventasContext.ventasRepository "Registra anticipos y saldos finales"
        woodroute.ventasContext.ventasRepository -> woodroute.ventasContext.ventasAggregate "Gestiona Aggregate"
        woodroute.ventasContext.ventasRepository -> woodroute.db "Lee y escribe pedidos, cotizaciones y pagos" "EF Core"

        woodroute.ventasContext.ventasPaymentService -> pasarelaPagos "Procesa anticipos y saldos finales" "HTTPS / Webhooks"

        // ─────────────────────────────────────────────
        // Producción Context — flujo interno y externo
        // ─────────────────────────────────────────────

        woodroute.produccionContext.produccionController -> woodroute.produccionContext.produccionService "Orquesta lógica de producción"
        woodroute.produccionContext.produccionService -> woodroute.produccionContext.produccionRepository "Usa repositorio"
        woodroute.produccionContext.produccionRepository -> woodroute.produccionContext.produccionAggregate "Gestiona Aggregate"
        woodroute.produccionContext.produccionRepository -> woodroute.db "Lee y escribe etapas y consumo de materiales" "EF Core"

        woodroute.produccionContext.produccionService -> cloudStorage "Sube fotos del avance de fabricación" "HTTPS"

        // ─────────────────────────────────────────────
        // Seguimiento y Comunicación Context — flujo interno y externo
        // ─────────────────────────────────────────────

        woodroute.seguimientoContext.seguimientoController -> woodroute.seguimientoContext.seguimientoMessageService "Orquesta lógica de mensajería"
        woodroute.seguimientoContext.seguimientoController -> woodroute.seguimientoContext.seguimientoReviewService "Orquesta lógica de reseñas y encuestas"
        woodroute.seguimientoContext.seguimientoMessageService -> woodroute.seguimientoContext.seguimientoRepository "Usa repositorio"
        woodroute.seguimientoContext.seguimientoReviewService -> woodroute.seguimientoContext.seguimientoRepository "Usa repositorio"
        woodroute.seguimientoContext.seguimientoMessageService -> woodroute.seguimientoContext.seguimientoNotificationService "Solicita envío de mensaje al cliente"
        woodroute.seguimientoContext.seguimientoReviewService -> woodroute.seguimientoContext.seguimientoNotificationService "Solicita envío de encuesta post-entrega"
        woodroute.seguimientoContext.seguimientoRepository -> woodroute.seguimientoContext.seguimientoAggregate "Gestiona Aggregate"
        woodroute.seguimientoContext.seguimientoRepository -> woodroute.db "Lee y escribe mensajes, encuestas y reseñas" "EF Core"

        woodroute.seguimientoContext.seguimientoNotificationService -> notificaciones "Envía correos, push y mensajes WhatsApp" "HTTPS / SDK"
    }

    views {

        systemContext woodroute "ContextView" {
            include *
            description "Diagrama de contexto del sistema WoodRoute. Los sistemas externos etiquetados como simulados se integran de forma mockeada en la iteración académica actual; su integración real está prevista para iteraciones futuras."
        }

        container woodroute "ContainerView" {
            include *
            description "Diagrama de containers del sistema WoodRoute. La Web Application (Vue 3 + Vite) consume la API REST expuesta por cinco bounded contexts agrupados bajo API Application, desplegados como un monolito modular en .NET 10. Los bounded contexts no se invocan entre sí en runtime: la integración entre ellos es mediada por la base de datos compartida (PostgreSQL), donde cada contexto es dueño de sus tablas y consulta directamente los datos que necesita de las tablas de otros contextos. Cada bounded context se integra además con sus sistemas externos correspondientes."
        }

        component woodroute.webApp "WebAppComponentsView" {
            include *
            description "Componentes de la Web Application. Las vistas se organizan por bounded context y consumen los endpoints REST a través de un API Client común; el estado de sesión y el estado del dominio se mantienen en stores de Pinia."
        }

        component woodroute.onboardingContext "OnboardingComponentsView" {
            include *
            description "Componentes del Onboarding Context. Patrón Controller → Service → Repository → Aggregate. El AuthService implementa la emisión y validación de JWT con .NET 10 Identity; el UserRepository persiste el aggregate User en la base de datos vía Entity Framework Core."
        }

        component woodroute.inventarioContext "InventarioComponentsView" {
            include *
            description "Componentes del Inventario Context. El MaterialService implementa el control de stock, genera órdenes de compra al proveedor cuando se detecta stock bajo (HU44) y sube imágenes de materiales al Cloud Storage. La integración con otros bounded contexts (consumo de materiales por Producción, consulta de disponibilidad por Ventas) se realiza vía la base de datos compartida — no existen llamadas directas en runtime."
        }

        component woodroute.ventasContext "VentasComponentsView" {
            include *
            description "Componentes del Cotización y Venta Context. El OrderService gestiona pedidos y cotizaciones; el PaymentService procesa anticipos y saldos finales contra la pasarela de pagos. La verificación de disponibilidad de materiales se realiza consultando directamente las tablas del Inventario Context en la base de datos compartida, sin llamadas en runtime a su servicio."
        }

        component woodroute.produccionContext "ProduccionComponentsView" {
            include *
            description "Componentes del Producción Context. El ProductionService registra el avance de las etapas de fabricación, sube fotos al Cloud Storage y registra el consumo de materiales escribiendo en la base de datos compartida (sin invocar al Inventario Context en runtime). Los cambios de etapa quedan persistidos para que el Seguimiento Context los pueda observar y notificar al cliente."
        }

        component woodroute.seguimientoContext "SeguimientoComponentsView" {
            include *
            description "Componentes del Seguimiento y Comunicación Context. El MessageService gestiona mensajería con el cliente, el ReviewService gestiona encuestas y reseñas, y el NotificationService centraliza el envío de correos, push y mensajes WhatsApp a través del proveedor externo. El NotificationService observa eventos relevantes en la base de datos compartida (cambios de etapa, presupuestos emitidos, alertas de stock, etc.) y dispara las notificaciones correspondientes; los demás bounded contexts no lo invocan directamente."
        }

        styles {
            element "Person" {
                shape Person
                background #08427B
                color #FFFFFF
            }
            element "Software System" {
                background #1168BD
                color #FFFFFF
                shape RoundedBox
            }
            element "Container" {
                background #438DD5
                color #FFFFFF
                shape RoundedBox
            }
            element "BoundedContext" {
                background #2C7A2C
                color #FFFFFF
            }
            element "Component" {
                background #85BBF0
                color #000000
                shape RoundedBox
            }
            element "Aggregate" {
                background #FFB347
                color #000000
            }
            element "Database" {
                shape Cylinder
            }
            element "External" {
                background #999999
                color #FFFFFF
            }
            element "Simulated" {
                border Dashed
            }
            relationship "Relationship" {
                routing Curved
            }
        }
    }
}
