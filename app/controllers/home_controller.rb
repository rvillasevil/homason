class HomeController < ApplicationController
  skip_before_action :set_current_user

  def index
    render json: homepage_payload
  end

  private

  def homepage_payload
    {
      brand: {
        name: "Homason",
        tagline: "Albañiles verificados on demand para reformas sin sorpresas"
      },
      hero: {
        headline: "Tu obra, en buenas manos desde la app",
        subheadline: "Reserva albañiles certificados por jornada, controla materiales y disfruta de total flexibilidad.",
        primary_cta: "Reserva una jornada",
        secondary_cta: "Descubre cómo funciona"
      },
      value_proposition: {
        customer: [
          "Albañiles verificados on demand disponibles por día o bloques de 4/8 horas.",
          "Transparencia total: conoces el precio antes de confirmar.",
          "Flexibilidad absoluta: cancela cuando quieras, sin permanencia.",
          "Gestión de materiales a tu manera: los aportas o los compramos vía app.",
          "Garantía de calidad gracias a valoraciones, fotos, seguro y visita técnica opcional."
        ],
        professional: [
          "Flujo constante de trabajos ajustados a tu zona y disponibilidad.",
          "Pagos asegurados y puntuales gestionados por la plataforma.",
          "Menos tiempo buscando clientes, más tiempo facturable en obra."
        ]
      },
      customer_segments: {
        individuals: "Particulares que necesitan pequeñas reformas, arreglos o mantenimiento continuo.",
        property_hosts: "Propietarios con varias viviendas o hosts de Airbnb que requieren intervenciones rápidas y recurrentes.",
        businesses: "Pequeñas empresas y comercios que buscan mantenimiento periódico de tabiques, suelos o pequeñas obras.",
        future_opportunities: "Expansión hacia promotoras pequeñas y administradores de fincas."
      },
      service_design: {
        customer_flow: [
          "Elige el tipo de tarea: tabiques, alicatado, reparación de humedades y más.",
          "La app sugiere jornadas estimadas, necesidad de visita previa y materiales requeridos.",
          "Define si ya tienes los materiales o si prefieres que los gestionemos.",
          "Reserva días y franjas horarias según tu agenda.",
          "Paga con plan recurrente flexible o por proyecto/día y pausa cuando quieras desde la app."
        ],
        professional_flow: [
          "Inscripción con verificación de documentación y experiencia.",
          "Asignación inteligente de trabajos por zona, rating y disponibilidad.",
          "Cobro por jornada o bloque horario con comisión gestionada por la startup."
        ]
      },
      revenue_model: {
        subscription: {
          name: "Plan Casa Segura",
          description: "Suscripción flexible que incluye 1 jornada mensual a precio reducido, prioridad en agenda y soporte " \
                       "rápido.",
          rules: [
            "Renovación automática mensual sin permanencia.",
            "Posibilidad de acumular jornadas hasta un límite de meses definido.",
            "Cancelación cuando quieras sin devoluciones del mes ya cobrado."
          ]
        },
        day_passes: {
          pricing: "Precio estimado entre 160€ y 220€ por jornada completa, con bloques disponibles.",
          distribution: "Reparto transparente entre profesional y plataforma (20-30% de comisión).",
          rationale: "Bloques reducen fricciones respecto a tarifas por hora."
        },
        materials: {
          strategy: "Acuerdos con almacenes para obtener descuentos profesionales y mantener margen.",
          offerings: [
            "Packs predefinidos como 'Pack tabique 10m²' o 'Pack reforma lavabo'.",
            "Presupuestos personalizados con entrega coordinada."
          ]
        },
        b2b_services: {
          targets: "Administradores de fincas y cadenas de locales.",
          benefits: [
            "Cuotas mensuales con SLA garantizados y gestor dedicado.",
            "Tarifas especiales por volumen de jornadas."
          ]
        }
      },
      operations: {
        quality_control: [
          "Proceso exigente de curación y verificación de profesionales.",
          "Sistema de reviews con expulsión si la calidad no se mantiene.",
          "Seguro de responsabilidad civil y política clara de revisitas."
        ],
        materials_logistics: "Integración con proveedores para coordinar entrega según fecha de obra.",
        payments: "El cliente paga a la plataforma y el profesional cobra al finalizar, menos comisión. Suscripciones domiciliadas."
      },
      sustainability: {
        promise: "Pago periódico y cancela cuando quieras sin comprometer la viabilidad.",
        mechanics: [
          "Beneficios tangibles en la cuota: precio reducido, prioridad y acumulación parcial.",
          "Bonos de jornadas (3, 5, 10) con descuento que se conservan aunque canceles renovaciones.",
          "Sin permanencia pero sin devoluciones del ciclo ya cobrado."
        ]
      },
      key_metrics: [
        "CAC vs LTV por segmento de cliente.",
        "Número de jornadas por cliente y por mes.",
        "Porcentaje de suscriptores frente a usuarios puntuales.",
        "Retención de profesionales activos en la plataforma.",
        "Margen medio por jornada tras pagar al albañil.",
        "NPS y valoración media por trabajo completado."
      ]
    }
  end
end
