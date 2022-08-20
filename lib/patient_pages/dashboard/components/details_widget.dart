import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientDetailsBloc, PatientDetailsResult?>(
      builder: ((context, state) {
        if (state != null && (state.name ?? '').isNotEmpty) {
          return Row(
            children: [
              Flexible(
                flex: 3,
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    state.profileImage ?? '',
                    width: 80,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.name ?? '',
                      style: context.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.primary),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.email ?? '',
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
