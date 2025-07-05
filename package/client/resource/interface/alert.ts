interface AlertDialogProps {
  header: string;
  content: string;
  centered?: boolean;
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl';
  overflow?: boolean;
  cancel?: boolean;
  labels?: {
    cancel?: string;
    confirm?: string;
  };
}

type alertDialog = (data: AlertDialogProps) => Promise<'cancel' | 'confirm'>;

<<<<<<< HEAD
export const alertDialog: alertDialog = async (data) => await exports.ox_lib.alertDialog(data);

export const closeAlertDialog = () => exports.ox_lib.closeAlertDialog();
=======
export const alertDialog: alertDialog = async (data, timeout?: number) =>
  await exports.ox_lib.alertDialog(data, timeout);

export const closeAlertDialog = (reason?: string) => exports.ox_lib.closeAlertDialog(reason);
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
